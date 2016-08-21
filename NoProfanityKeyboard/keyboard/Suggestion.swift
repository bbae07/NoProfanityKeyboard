//
//  Suggestion.swift
//  NoProfanityKeyboard
//
//  Created by 이경문 on 2016. 8. 14..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

protocol TestProtocol {
    func onButtonTap(sender: UIButton)
}

class Suggestion: UIView {
    var delegate: TestProtocol?

    @IBOutlet weak var b2: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNib()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.loadNib()
    }

    func loadNib(){
        let view = NSBundle.mainBundle().loadNibNamed("TestView", owner: self, options: nil).first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        b2.addTarget(self, action: #selector(test(_:)
            ), forControlEvents: .TouchUpInside)
    }
    func test(sender:UIButton){
        NSLog("test")
        self.onButtonTap(sender)
    }
    func onButtonTap(sender: UIButton) {
        // invoking the delegate when the
        // button is actually tapped
        delegate?.onButtonTap(sender)
    }
}