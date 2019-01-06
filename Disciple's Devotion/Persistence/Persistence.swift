//
//  Persistence.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    private init(){}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DiscipleDevotion")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    static func fetchDailyVerse(entityName: String, sorting: NSSortDescriptor? = nil) throws -> DailyVerse? {
        let fetchRequest: NSFetchRequest<DailyVerse> = DailyVerse.fetchRequest()
        fetchRequest.fetchLimit = 1
        if let sorting = sorting {
            fetchRequest.sortDescriptors = [sorting]
        }
        guard let dailyVerse = (try PersistenceService.context.fetch(fetchRequest)).first else {
            return nil
        }
        return dailyVerse
    }
    
    static func fetchBiblePlan(sorting: NSSortDescriptor? = nil) throws -> [BiblePlan]? {
        var biblePlan  = [BiblePlan]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BiblePlan")
        let sort = NSSortDescriptor(key: #keyPath(BiblePlan.day), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        biblePlan = try context.fetch(fetchRequest) as! [BiblePlan]
        return biblePlan
    }
    
    static func loadDailyVerse() -> DailyVerse? {
        var dailyVerse: DailyVerse?
        do {
            try dailyVerse = fetchDailyVerse(entityName: "DailyVerse")
        } catch {
            
        }
        return dailyVerse
    }
    
    static func loadYearPlan() -> [BiblePlan]? {
        var biblePlan: [BiblePlan]?
        do {
            try biblePlan = fetchBiblePlan()
        } catch {
        }
        let sortedBiblePlan = biblePlan!.sorted {$0.day!.localizedStandardCompare($1.day!) == .orderedAscending}
        
        return sortedBiblePlan
    }
    
    static func dropAllData(){
        if let psc = PersistenceService.context.persistentStoreCoordinator{
            
            if let store = psc.persistentStores.last{
                let storeUrl = psc.url(for: store)
                PersistenceService.context.performAndWait(){
                    PersistenceService.context.reset()
                    try! FileManager.default.removeItem(at: storeUrl)
                }
            }
        }
    }
    
}
