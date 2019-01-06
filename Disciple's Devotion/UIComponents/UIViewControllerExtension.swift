//
//  UIViewControllerExtension.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/19/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func raiseAlert(title:String, notification:String) {
        let alert  = UIAlertController(title: title, message: notification, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
}
