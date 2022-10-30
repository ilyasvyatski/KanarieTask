//
//  URLSessionHTTPClient.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

public enum HTTPHeaderFields {
    case year
    case month
    case week
    case day
    case none
}

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
  
    // MARK: - HTTP Client
    public func get(_ url: URL, params: [String : String], httpHeader: HTTPHeaderFields, responseHandler: @escaping (ResponseResult) -> Void) {
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Error: cannot create URLCompontents")
            return
        }
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }

        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        switch httpHeader {
            case .year:
                request.setValue("2022", forHTTPHeaderField: "year")
                request.setValue("08:00:2b:01:02:03", forHTTPHeaderField: "mac")
                request.setValue("panel", forHTTPHeaderField: "target")
            case .month:
                request.setValue("2022", forHTTPHeaderField: "year")
                request.setValue("08:00:2b:01:02:03", forHTTPHeaderField: "mac")
                request.setValue("10", forHTTPHeaderField: "month")
                request.setValue("panel", forHTTPHeaderField: "target")
            case .week:
                request.setValue("2022-10-26", forHTTPHeaderField: "date_from")
                request.setValue("08:00:2b:01:02:03", forHTTPHeaderField: "mac")
                request.setValue("2022-10-19", forHTTPHeaderField: "date_to")
                request.setValue("panel", forHTTPHeaderField: "target")
            case .day:
                request.setValue("2022-10-26", forHTTPHeaderField: "date")
                request.setValue("08:00:2b:01:02:03", forHTTPHeaderField: "mac")
                request.setValue("panel", forHTTPHeaderField: "target")
            case .none: break
        }

        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request) { data, response, error in
            
            let handledResponse = Self.handle(data: data, error: error, response: response)
            
            switch handledResponse {
                case .success(let _data):
                    responseHandler(.success(_data))
                case .failure(let _error):
                    responseHandler(.failure(_error))
            }
        }.resume()
    }
}

// MARK: - Response handlers
extension URLSessionHTTPClient {
    
    internal static func handle(data: Data?, error: Error?, response: URLResponse?) -> Result<Data,URLSessionHTTPClientError> {
        
        if let _data = data, error == nil, let _response = response, let _ = _response as? HTTPURLResponse {
            return .success(_data)
        }
    
        if let _error = error {
            return .failure(.error(_error))
        }
        return .failure(.unknown(data, response, error))
    }
}
