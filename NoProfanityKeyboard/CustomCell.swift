//
//  CustomCell.swift
//  NoProfanityKeyboard
//
//  Created by 이경문 on 2016. 8. 14..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var swear: UILabel!
    @IBOutlet weak var noChange: UILabel!
    @IBOutlet weak var yesChange: UILabel!

    var swearStr = "WORD"
    var noStr    = "SAME"
    var yesStr   = "CHANGE"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.swear.text = swearStr
        self.noChange.text = noStr
        self.yesChange.text = yesStr
        // Initialization code
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
