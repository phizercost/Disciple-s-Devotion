//
//  LessonsParser.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/27/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation

struct LessonsParser: Codable {
    let items: [Items]
}

struct Items: Codable {
    
    let title: String
    let url: String
    let image_mq: String
}
