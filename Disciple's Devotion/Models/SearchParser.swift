//
//  SearchParser.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/20/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation


struct SearchParser: Codable {
    let data: DataElements
}

struct DataElements: Codable {
    
    let query: String
    let total: Int
    let verses: [Verses]
}

struct Verses: Codable {
    
    let id: String
    let reference: String
    let text: String
}
