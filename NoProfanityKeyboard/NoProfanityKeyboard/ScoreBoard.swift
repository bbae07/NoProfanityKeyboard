//
//  ScoreBoard.swift
//  NoProfanityKeyboard
//
//  Created by Brian Bae on 2016. 8. 27..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

protocol ScoreProtocol {
    func reloadScore()
}

class ScoreBoard: UIView {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var delegate:ScoreProtocol?

    func reloadScore(){

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNib()
    }

    func loadNib(){
        let view = NSBundle.mainBundle().loadNibNamed("ScoreBoard", owner: self, options: nil).first as! UIView
        
        view.frame = self.bounds
        self.addSubview(view)
    }



}
