//
//  BiblePlanParser.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 1/3/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import Foundation


struct BiblePlanParser: Codable {
    var plan: [Plans]
}

struct Plans: Codable {
    
    let day: String
    let references: [String]
    var status: Bool
}


