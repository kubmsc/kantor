//
//  KantorManager.swift
//  kantor
//
//  Created by Kuba  on 24/04/2020.
//  Copyright © 2020 Kuba . All rights reserved.
//

import Foundation

protocol KantorManagerDelegate {
    func didUpdateCurrency(_ kantorManager: KantorManager, kantor: KantorModel)
    func didFailWithError(error: Error)
}

struct KantorManager {
    let kantorURL = "https://prime.exchangerate-api.com/v5/4105bd4ea71d84078166cedf/latest"
    
    var delegate: KantorManagerDelegate?
    
    func getCurrencyPrice(currencyName: String) {
        let urlString = "\(kantorURL)/\(currencyName)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let  safeData = data {
                    if let kantor = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCurrency(self, kantor: kantor)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ kantorData: Data) -> KantorModel? {
        let decoder = JSONDecoder()
        do {
            let decodedDate = try decoder.decode(KantorData.self, from: kantorData)
            
            let base = decodedDate.base
            let USD = decodedDate.conversion_rates.USD
            let EUR = decodedDate.conversion_rates.EUR
            let PLN = decodedDate.conversion_rates.PLN
            let GBP = decodedDate.conversion_rates.GBP
            
            let kantor = KantorModel(usd: USD, eur: EUR, pln: PLN, gbp: GBP, base: base )
            
            return kantor
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil 
        }
    }
}

