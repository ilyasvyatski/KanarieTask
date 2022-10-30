//
//  URLSessionHTTPClientError.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

public enum URLSessionHTTPClientError: Error {
    
    case error(Error)
    case unknown(Data?, URLResponse?, Error?)
}
