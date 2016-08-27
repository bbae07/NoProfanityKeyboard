//
//  ScoreBoard.swift
//  NoProfanityKeyboard
//
//  Created by Brian Bae on 2016. 8. 27..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

class ScoreBoard: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ScoreBoard", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }


}
