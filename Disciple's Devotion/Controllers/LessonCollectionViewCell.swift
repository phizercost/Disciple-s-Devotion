//
//  LessonCollectionViewCell.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/27/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

class LessonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLbl: UILabel!
    var url: String!
}
