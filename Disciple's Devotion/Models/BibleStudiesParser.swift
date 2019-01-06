//
//  BibleStudiesParser.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/26/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation

struct BibleStudiesParser: Codable {
    let items: [ItemElements]
}

struct ItemElements: Codable {
    
    let title: String
    let subtitle: String
    let slug: String
    let excerpt: String
    let image: String
    let thumb: String
    let num_lessons: String
}
