//
//  ElementModel.swift
//  AC3.2-MidtermElements
//
//  Created by Edward Anchundia on 12/8/16.
//  Copyright © 2016 Edward Anchundia. All rights reserved.
//

import Foundation

class Elements {
    let recordURL: String?
    let number: Int?
    let weight: Double?
    let name: String?
    let symbol: String?
    let meltingC: Int?
    let boilingC: Int?
    let discoveryYear: String?
    let electrons: String?
    let ionEnergy: Double?
    
    init(recordURL: String?, number: Int?, weight: Double?, name: String?, symbol: String?, meltingC: Int?, boilingC: Int?, discoveryYear: String?, electrons: String?, ionEnergy: Double?) {
        self.recordURL = recordURL
        self.number = number
        self.name = name
        self.weight = weight
        self.symbol = symbol
        self.meltingC = meltingC
        self.boilingC = boilingC

        self.discoveryYear = discoveryYear
        self.electrons = electrons
        self.ionEnergy = ionEnergy
    }
    
    static func elements(from data: Data) -> [Elements]? {
        var results: [Elements]? = []
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
        
            if let validJSON = json {
                for data in validJSON {
                    guard let recordURL = data["record_url"] as? String ?? nil,
                        let number = data["number"] as? Int ?? nil,
                        let weight = data["weight"] as? Double ?? nil,
                        let name = data["name"] as? String ?? nil,
                        let symbol = data["symbol"] as? String ?? nil,
                        let meltingC = data["melting_c"] as? Int ?? nil,
                        let boilingC = data["boiling_c"] as? Int ?? nil,
                        let discoveryYear = data["discovery_year"] as? String ?? nil,
                        let electrons = data["electrons"] as? String ?? nil,
                        let ionEnergy = data["ion_energy"] as? Double ?? nil else {
                            continue
                    }
                    let detail = Elements(recordURL: recordURL, number: number, weight: weight, name: name, symbol: symbol, meltingC: meltingC, boilingC: boilingC, discoveryYear: discoveryYear, electrons: electrons, ionEnergy: ionEnergy)
                    results?.append(detail)
                }
            }
            return results
        } catch {
            print("Error parsing: \(error)")
        }
        return nil
    }
}
