//
//  Global.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

class Global: NSObject {
    
    var session = URLSession.shared
    
    override init() {
        super.init()
    }
    var dailyVerse: DailyVerse?
    var verseSearched: String?
    var referenceSearched: String?
    var bibleStudies: BibleStudiesParser?
    var lessons: LessonsParser?
    var searchResults = SearchParser.init(data: DataElements(query: "", total: 0, verses: []))
    var biblePlan: [BiblePlan] = []
    static let shared = Global()
}
