//
//  KanarieEnergyData.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

typealias KanarieEnergies = [KanarieEnergyData]

struct KanarieEnergyData {
    let id: Int
    let energyDeltaKwh: Double
}

extension KanarieEnergyData {
    static var empty: KanarieEnergyData { KanarieEnergyData(id: 0,  energyDeltaKwh: 0.0) }
}
