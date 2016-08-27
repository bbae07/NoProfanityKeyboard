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

    var scoreString:String = ""
    var commentString:String = ""

    var delegate:ScoreProtocol?

    func reloadScore(){
        /*
         알고리즘의 결과로 점수(Int 또는 String)과 해당 점수에 맞는 코멘트 String이 넘어와야함
         */
        self.scoreString = ((1+random() % 100) as NSNumber).stringValue //"100"
        self.commentString = "YOU'RE DOING GREAT!"
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
        self.reloadScore()
        commentLabel.text = self.commentString
        scoreLabel.text = self.scoreString
        self.addSubview(view)
    }



}
