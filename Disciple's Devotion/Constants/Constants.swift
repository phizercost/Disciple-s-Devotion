//
//  Constants.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation

struct Constants {
    
    
    
    //MARK:-Our Manna API
    struct OurManna {
        static let url = "https://beta.ourmanna.com/api/v1/"
        static let format = "json"
        static let method = "get"
        static let separator = "/"
        static let order = "random"
    }
    
    //MARK:-API Scripture
    struct Scripture {
        static let url = "https://api.scripture.api.bible/v1/bibles/"
        static let bibleId = "de4e12af7f28f599-01"
        static let method = "search"
        static let separator = "/"
        static let limit = "100"
        static let apiKey = "9a4d152bea51bd4369785c46ed8caf74"
    }
    
    //MARK:-API Bible Studies
    struct BibleStudies {
        static let url = "https://bibletalk.tv/"
        static let series = "series"
        static let format = "json"
    }
    
    //MARK:-API Year Plan Reading
    struct YearPlan {
        static let url = "http://labs.bible.org/api/"
    }
}
