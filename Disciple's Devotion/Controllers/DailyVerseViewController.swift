//
//  DailyVerseViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

class DailyVerseViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dailyVerseLbl: UILabel!
    @IBOutlet weak var referenceLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        
        getDailyVerse()
    }
    
    private func getDailyVerse() {
        activityIndicator.startAnimating()
        Global.shared.getDailyVerse() { (parsedVerse, error) in
            if (parsedVerse != nil) {
                let dailyVerse = DailyVerse(context: PersistenceService.context)
                dailyVerse.verse = parsedVerse?.verse.details.text
                dailyVerse.reference = (parsedVerse?.verse.details.reference)! + " " + (parsedVerse?.verse.details.version)!
                Global.shared.dailyVerse = dailyVerse
                PersistenceService.saveContext()
                self.dailyVerseLbl.text = dailyVerse.verse
                self.referenceLbl.text = dailyVerse.reference
                self.activityIndicator.stopAnimating()
                
            } else {
                DispatchQueue.main.async {
                    if (error == "A problem occured while getting the daily verse" || error == "No daily Verse Available" || error == "The Internet connection appears to be offline.") {
                        if let dailyVerse = PersistenceService.loadDailyVerse(){
                            Global.shared.dailyVerse = dailyVerse
                            self.dailyVerseLbl.text = dailyVerse.verse
                            self.referenceLbl.text = dailyVerse.reference
                            self.activityIndicator.stopAnimating()
                        }
                        else {
                            self.raiseAlert(title: "ERROR", notification: error!)
                            self.activityIndicator.stopAnimating()
                        }
                    } else {
                        self.raiseAlert(title: "ERROR", notification: error!)
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }

}
