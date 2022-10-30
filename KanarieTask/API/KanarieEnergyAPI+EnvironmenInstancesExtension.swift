//
//  KanarieEnergyAPI+EnvironmenInstancesExtension.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

extension KanarieEnergyAPI {
    static var dev: Self {
        KanarieEnergyAPI(environment: KanarieEnergyEnvironment())
    }
}
