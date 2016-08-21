//
//  Suggestion.swift
//  NoProfanityKeyboard
//
//  Created by 이경문 on 2016. 8. 14..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

class Suggestion: NibLoadingView {

    @IBOutlet weak var Btn_1: UIButton!
    @IBOutlet weak var Btn_2: UIButton!
    @IBOutlet weak var Btn_3: UIButton!


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
@IBDesignable
class NibLoadingView: UIView {

    @IBOutlet weak var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }

    private func nibSetup() {
        backgroundColor = .clearColor()

        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true

        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: String(self.dynamicType), bundle: bundle)
        let nibView = nib.instantiateWithOwner(self, options: nil).first as! UIView
        
        return nibView
    }
    
}