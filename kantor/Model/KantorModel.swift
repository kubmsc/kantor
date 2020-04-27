//
//  KantorModel.swift
//  kantor
//
//  Created by Kuba  on 25/04/2020.
//  Copyright © 2020 Kuba . All rights reserved.
//

import Foundation

struct KantorModel {
    
    let usd: Double
    let eur: Double
    let pln: Double
    let gbp: Double
    let base: String
    
    var usdString: String {
        return String(format: "%.2f", usd )
    }
    var eurString: String {
        return String(format: "%.2f", eur )
    }
    var plnString: String {
        return String(format: "%.2f", pln)
    }
    var gbpString: String {
        return String(format: "%.2f", gbp)
    }
}
