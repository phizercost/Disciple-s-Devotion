//
//  RoundButton.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/13/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//
import UIKit
class RoundButton: UIButton {
    override func didMoveToWindow() {
        self.backgroundColor = .clear
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 4.0
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.showsTouchWhenHighlighted = true
    }
}
