//
//  KanarieEnergyAPI+MappingExtension.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

extension KanarieEnergyAPI {
    var yearURL: URL { getURL(path: "year") }
    var monthURL: URL { getURL(path: "month") }
    var weekURL: URL { getURL(path: "week") }
    var dayURL: URL { getURL(path: "day") }
}

// MARK: - Helpers
fileprivate extension KanarieEnergyAPI {
    
    func getURL(path: String) -> URL {
        URL(string: "\(environment.baseURL)-\(path)")!
    }
}
