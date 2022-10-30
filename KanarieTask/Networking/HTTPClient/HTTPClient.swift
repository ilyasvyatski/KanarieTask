//
//  HTTPClient.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

public protocol HTTPClient {
    
    typealias ResponseResult = Result<Data, Error>
    
    func get(_ url: URL, params: [String: String], httpHeader: HTTPHeaderFields, responseHandler: @escaping (ResponseResult) -> Void)
}
