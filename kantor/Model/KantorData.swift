//
//  KantorData.swift
//  kantor
//
//  Created by Kuba  on 24/04/2020.
//  Copyright © 2020 Kuba . All rights reserved.
//

import Foundation

struct KantorData: Decodable {
    let base: String
    let conversion_rates: Conversion_rates
}
struct Conversion_rates: Decodable {
    let USD: Double
    let EUR: Double
    let PLN: Double
    let GBP: Double
}
