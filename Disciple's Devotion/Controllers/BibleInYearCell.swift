//
//  BibleInYearCell.swift
//  Disciple's Devotion
//
//  Created by Phizer Cost on 1/2/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit

class BibleInYearCell: UITableViewCell {

    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var chkBtn: CellButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
