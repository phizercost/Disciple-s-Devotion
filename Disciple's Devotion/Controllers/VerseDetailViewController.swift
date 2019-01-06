//
//  VerseDetailViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/24/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

class VerseDetailViewController: UIViewController {

    @IBOutlet weak var verseLble: UILabel!
   
    @IBOutlet weak var referenceLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.94, alpha:1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        verseLble.text = Global.shared.verseSearched
        referenceLbl.text = Global.shared.referenceSearched
    }

}
