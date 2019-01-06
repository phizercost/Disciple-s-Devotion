//
//  DaiilyVerseParser.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation


struct DailyVerseParser: Codable {
    let verse: VerseElements
}

struct VerseElements: Codable {
    
    let details: VerseDetails
    let notice: String
}

struct VerseDetails: Codable {
    
    let text: String
    let reference: String
    let version: String
    let verseurl: String
}
