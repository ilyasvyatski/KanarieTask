//
//  KanarieEnergyRemoteRepository.swift
//  KanarieTask
//
//  Created by Илья Свяцкий on 10/27/22.
//

import Foundation

final internal class KanarieEnergyRemoteRepository: KanarieEnergyRepository {
    
    private let httpClient: HTTPClient
    private let api: KanarieEnergyAPI
    private let executionQueue: DispatchQueue
    
    internal init(httpClient: HTTPClient, api: KanarieEnergyAPI, executionQueue: DispatchQueue = .main) {
        self.httpClient = httpClient
        self.api = api
        self.executionQueue = executionQueue
    }
  
  // MARK: - KanarieEnergyRepository
    func getKanarieEnergyYear(handler: @escaping (KanarieEnergyResult) -> Void) {
        httpClient.get(api.yearURL, params: ["": ""], httpHeader: .year) { [unowned self] result in
            self.execute {
                switch result {
                    case .success(let data):
                        if let dto = Self.parse(type: KanarieEnergiesDTO.self, data: data) {
                            handler(.success(dto.fetchData(kanarieEnergiesDTO: dto)))
                        } else {
                            handler(.failure(.notParsable(data)))
                        }
                    case .failure(let error):
                        handler(.failure(.fetchError(error)))
                        
                }
            }
        }
    }
    
    func getKanarieEnergyMonth(handler: @escaping (KanarieEnergyResult) -> Void) {
        httpClient.get(api.monthURL, params: ["": ""], httpHeader: .month) { [unowned self] result in
            self.execute {
                switch result {
                    case .success(let data):
                        if let dto = Self.parse(type: KanarieEnergiesDTO.self, data: data) {
                            handler(.success(dto.fetchData(kanarieEnergiesDTO: dto)))
                        } else {
                            handler(.failure(.notParsable(data)))
                        }
                    case .failure(let error):
                        handler(.failure(.fetchError(error)))
                        
                }
            }
        }
    }
    
    func getKanarieEnergyWeek(handler: @escaping (KanarieEnergyResult) -> Void) {
        httpClient.get(api.weekURL, params: ["": ""], httpHeader: .week) { [unowned self] result in
            self.execute {
                switch result {
                    case .success(let data):
                        if let dto = Self.parse(type: KanarieEnergiesDTO.self, data: data) {
                            handler(.success(dto.fetchData(kanarieEnergiesDTO: dto)))
                        } else {
                            handler(.failure(.notParsable(data)))
                        }
                    case .failure(let error):
                        handler(.failure(.fetchError(error)))
                        
                }
            }
        }
    }
    
    func getKanarieEnergyDay(handler: @escaping (KanarieEnergyResult) -> Void) {
        httpClient.get(api.dayURL, params: ["": ""], httpHeader: .day) { [unowned self] result in
            self.execute {
                switch result {
                    case .success(let data):
                        if let dto = Self.parse(type: KanarieEnergiesDTO.self, data: data) {
                            handler(.success(dto.fetchData(kanarieEnergiesDTO: dto)))
                        } else {
                            handler(.failure(.notParsable(data)))
                        }
                    case .failure(let error):
                        handler(.failure(.fetchError(error)))
                        
                }
            }
        }
    }
    // MARK: - Helpers
    private func execute(action: @escaping () -> Void) {
        executionQueue.async(execute: action)
    }
    
    private static func parse<T: Decodable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .custom({ keys in
            let key = keys.last!.stringValue
            switch key {
            case "month", "DayOfMonth", "DayOfWeek", "hour":
                return AnyKey(stringValue: "id")!
            default:
                return keys.last!
            }
        })
        //return try? JSONDecoder().decode(T.self, from: data)
        return try? decoder.decode(T.self, from: data)
    }
}

fileprivate extension KanarieEnergiesDTO {
    func fetchData(kanarieEnergiesDTO: KanarieEnergiesDTO) -> KanarieEnergies {
        var vms = [KanarieEnergyData]()
        for kanarieEnergyItem in kanarieEnergiesDTO {
            vms.append(createModel(kanarieEnergieDTO: kanarieEnergyItem))
        }
        
        return vms
    }
    /*var toData: KanarieEnergies {
        
        //return KanarieEnergyData(month: self.month, energyMin: self.energyMin, energyMax: self.energyMax, energyDelta: self.energyDelta, energyDeltaKwh: self.energyDeltaKwh, Duration: self.Duration)
        //return KanarieEnergyData(factMessage: facts.reduce(into: "", { $0.append(contentsOf: $1) }))
        // Cache
        var vms = [KanarieEnergyData]()
        for kanarieEnergyItem  {
            vms.append(createModel(kanarieEnergieDTO: kanarieEnergyItem))
        }
        
        return vms
    }*/
}

func createModel(kanarieEnergieDTO: KanarieEnergyDTO) -> KanarieEnergyData {
    let id = kanarieEnergieDTO.id
    let energyDeltaKwh = kanarieEnergieDTO.energyDeltaKwh
    
    return KanarieEnergyData(id: id,energyDeltaKwh: energyDeltaKwh)
}
