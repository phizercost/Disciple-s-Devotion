//
//  DDViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/13/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

class DDViewController: UIViewController {

    
    
    
    
    @IBOutlet weak var quickSearch: RoundButton!
    @IBOutlet weak var bibleYear: RoundButton!
    @IBOutlet weak var bibleStudy: RoundButton!
    @IBOutlet weak var dailyVerse: RoundButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
        prepareButtons()
        
        
         // Do any additional setup after loading the view.
    }
    
    // MARK: - Menu Buttons
    fileprivate func prepareButtons() {
        dailyVerse.centerVertically()
        bibleStudy.centerVertically()
        bibleYear.centerVertically()
        quickSearch.centerVertically()
    }

}
