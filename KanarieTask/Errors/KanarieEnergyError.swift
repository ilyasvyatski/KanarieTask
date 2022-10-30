//
//  KanarieEnergyError.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

enum KanarieEnergyError: Error {
    case notParsable(Data)
    case fetchError(Error)
}

