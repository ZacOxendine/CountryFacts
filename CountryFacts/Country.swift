//
//  Country.swift
//  CountryFacts
//
//  Created by Zachary Oxendine on 9/23/20.
//  Copyright © 2020 Zachary Oxendine. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var region: String
    var population: Int
    var area: Double?
}
