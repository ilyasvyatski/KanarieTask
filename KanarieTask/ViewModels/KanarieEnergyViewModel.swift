//
//  KanarieEnergyViewModel.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

final class KanarieEnergyViewModel {
    private let repository: KanarieEnergyRepository
    
    private let onSuccess: (_ factValue: KanarieEnergies) -> Void
    private let onError: (_ errorMessage: String) -> Void
    
    init(
        repository: KanarieEnergyRepository,
        onSuccess: @escaping (_ factValue: KanarieEnergies) -> Void,onError: @escaping (_ errorMessage: String) -> Void
    ) {
        self.repository = repository
        self.onSuccess = onSuccess
        self.onError = onError
    }
    
    func fetchKanarieEnergyYear() {
        repository.getKanarieEnergyYear { [unowned self] result in
            switch result {
            case .success(let factData):
                self.onSuccess(factData)
            case .failure(let error):
                self.onError(error.localizedDescription)
            }
        }
    }
    
    func fetchKanarieEnergyMonth() {
        repository.getKanarieEnergyMonth { [unowned self] result in
            switch result {
            case .success(let factData):
                self.onSuccess(factData)
            case .failure(let error):
                self.onError(error.localizedDescription)
            }
        }
    }
    
    func fetchKanarieEnergyWeek() {
        repository.getKanarieEnergyWeek { [unowned self] result in
            switch result {
            case .success(let factData):
                self.onSuccess(factData)
            case .failure(let error):
                self.onError(error.localizedDescription)
            }
        }
    }
    
    func fetchKanarieEnergyDay() {
        repository.getKanarieEnergyDay { [unowned self] result in
            switch result {
            case .success(let factData):
                self.onSuccess(factData)
            case .failure(let error):
                self.onError(error.localizedDescription)
            }
        }
    }
}
