//
//  KanarieEnergyRepository.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

protocol KanarieEnergyRepository {
    
    typealias KanarieEnergyResult = Result<KanarieEnergies, KanarieEnergyError>
    
    func getKanarieEnergyYear(handler: @escaping (KanarieEnergyResult) -> Void)
    func getKanarieEnergyMonth(handler: @escaping (KanarieEnergyResult) -> Void)
    func getKanarieEnergyWeek(handler: @escaping (KanarieEnergyResult) -> Void)
    func getKanarieEnergyDay(handler: @escaping (KanarieEnergyResult) -> Void)
}
