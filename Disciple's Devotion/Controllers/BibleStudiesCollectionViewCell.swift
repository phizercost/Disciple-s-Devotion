//
//  CollectionViewCell.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 12/26/18.
//  Copyright © 2018 Phizer Cost. All rights reserved.
//

import UIKit

class BibleStudiesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var sectionsLbl: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var thumbUrl: String = ""
    
}
