//
//  DailyVerse+CoreDataProperties.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//
//

import Foundation
import CoreData


extension DailyVerse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyVerse> {
        return NSFetchRequest<DailyVerse>(entityName: "DailyVerse")
    }

    @NSManaged public var verse: String?
    @NSManaged public var reference: String?

}
