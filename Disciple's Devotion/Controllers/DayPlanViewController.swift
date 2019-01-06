//
//  DayPlanViewController.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 1/3/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit

class DayPlanViewController: UIViewController {

    

    @IBOutlet weak var txtView: UITextView!
   
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var reference: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.95, blue:0.96, alpha:1.0)
        reference = reference.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        getDailyScripture(ref: reference)
    }
    

    private func getDailyScripture(ref: String) {
        activityIndicator.startAnimating()
        Global.shared.getDailyReading(references: ref) { (text, error) in
            if (text != nil) {
                var formattedText = text!.replacingOccurrences(of: "<b>", with: "", options: .literal, range: nil)
                formattedText = formattedText.replacingOccurrences(of: "</b>", with: "", options: .literal, range: nil)
                self.txtView.text = formattedText
                self.activityIndicator.stopAnimating()
                
            } else {
                DispatchQueue.main.async {
                    
                    self.raiseAlert(title: "ERROR", notification: error!)
                    self.activityIndicator.stopAnimating()
                    
                }
            }
        }
    }

}
