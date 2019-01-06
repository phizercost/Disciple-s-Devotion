//
//  BiblePlan+CoreDataProperties.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 1/5/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//
//

import Foundation
import CoreData


extension BiblePlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BiblePlan> {
        return NSFetchRequest<BiblePlan>(entityName: "BiblePlan")
    }

    @NSManaged public var day: String?
    @NSManaged public var references: String?
    @NSManaged public var status: Bool

}
