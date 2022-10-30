//
//  KanarieEnergyDTO.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

typealias KanarieEnergiesDTO = [KanarieEnergyDTO]

internal struct KanarieEnergyDTO: Decodable {
    let id: Int
    let energyMin: Int
    let energyMax: Int
    let energyDelta: Int
    let energyDeltaKwh: Double
    let duration: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case energyMin
        case energyMax
        case energyDelta
        case energyDeltaKwh
        case duration = "Duration"
    }
}

struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        print(stringValue)
        self.stringValue = stringValue
        intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
