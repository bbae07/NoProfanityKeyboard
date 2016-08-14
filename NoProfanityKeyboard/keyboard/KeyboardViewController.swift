//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by 이경문 on 2016. 8. 13..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var topCharacterList:[String] = ["q","w","e","r","t","y","u","i","o","p"] // 10개
    var upperCharacterList:[String] = ["a","s","d","f","g","h","j","k","l"] // 9개
    var footerCharacterList:[String] = ["#","z","x","c","v","b","n","m","<-"] // 9개
    var bottomCharacterList:[String] = ["123","@@","space","return"] // 4개

    var topNumberList:[String] = ["1","2","3","4","5","6","7","8","9","0"]
    var upperNumberList:[String] = ["-","/",":",";","(",")","₩","&","@","\""]
    var footerNumberList:[String] = ["#+=",".",",","?","!","\'","<-"]
    var bottomNumberList:[String] = ["ABC","@@","space","return"]

    var topSymbolList:[String] = ["[","]","{","}","#","%","^","*","+","="]
    var upperSymbolList:[String] = ["_","\\","|","~","<",">","$","€","¥","•"]
    var footerSymbolList:[String] = ["123",".",",","?","!","\'","<-"]
    var bottomSymbolList:[String] = ["ABC","@@","space","return"]

    var topCapCharacterList:[String] = ["Q","W","E","R","T","Y","U","I","O","P"] // 10개
    var upperCapCharacterList:[String] = ["A","S","D","F","G","H","J","K","L"] // 9개
    var footerCapCharacterList:[String] = ["###","Z","X","C","V","B","N","M","<-"] // 9개
    var bottomCapCharacterList:[String] = ["123","@@","space","return"] // 4개

    var topShiftCharacterList:[String] = ["Q","W","E","R","T","Y","U","I","O","P"] // 10개
    var upperShiftCharacterList:[String] = ["A","S","D","F","G","H","J","K","L"] // 9개
    var footerShiftCharacterList:[String] = ["##","Z","X","C","V","B","N","M","<-"] // 9개
    var bottomShiftCharacterList:[String] = ["123","@@","space","return"] // 4개

    //var buttons:[UIButton]? = nil

    lazy var CharacterList: [[String]] = [self.topCharacterList,self.upperCharacterList,self.footerCharacterList,self.bottomCharacterList]

//#selector(advanceToNextInputMode)
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createKeyBoard()
    }

    func createKeyBoard()
    {
        for subview in self.view.subviews
        {
            subview.removeFromSuperview()
        }

        //self.view.

        //UITapGestureRecognizer *doubleTap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTap)] autorelease];
        //doubleTap.numberOfTapsRequired = 2;
        //[self.view addGestureRecognizer:doubleTap];
        var y:CGFloat = 0
        for array in CharacterList
        {
            var count:CGFloat = 0
            for member in array
            {
                let Btn = UIButton(frame:CGRect(x:count,y:y,width:UIScreen.mainScreen().bounds.size.width/CGFloat(array.count),height:CGFloat(224)/4))
                Btn.setTitle(member, forState: UIControlState.Normal)
                Btn.backgroundColor = UIColor.whiteColor()
                Btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                if(Btn.titleLabel?.text == "#")
                {
                    let doubleTap:UITapGestureRecognizer = UITapGestureRecognizer()
                    doubleTap.numberOfTapsRequired = 2
                    doubleTap.numberOfTouchesRequired = 1

                    doubleTap.addTarget(self, action: #selector(capsLock(_:)))
                    Btn.addGestureRecognizer(doubleTap)
                }

//                let singleTap:UITapGestureRecognizer = UITapGestureRecognizer()
//                singleTap.numberOfTapsRequired = 1
//                singleTap.numberOfTouchesRequired = 1
//                //singleTap.addTarget(self, action: #selector(nothing(_:)))
//                Btn.addGestureRecognizer(singleTap)
//
//                singleTap.requireGestureRecognizerToFail(doubleTap)

                Btn.addTarget(self, action: #selector(handleBtn(_:)), forControlEvents: .TouchUpInside)

                self.view.addSubview(Btn)
                count+=Btn.bounds.size.width
            }
            y+=CGFloat(224)/4
        }
        
    }

    func capsLock(sender:UITapGestureRecognizer)
    {
        CharacterList = [topCapCharacterList,upperCapCharacterList,footerCapCharacterList,bottomCapCharacterList]
        createKeyBoard()
    }

    func handleBtn(sender:UIButton)
    {
        let label = sender.titleLabel?.text
        if(label == "space")
        {
            self.textDocumentProxy.insertText(" ")
        }
        else if(label == "return")
        {
            self.textDocumentProxy.insertText("\n")
        }
        else if(label == "<-")
        {
            self.textDocumentProxy.deleteBackward()
        }
        else if(label == "#")
        {
            CharacterList = [topShiftCharacterList,upperShiftCharacterList,footerShiftCharacterList,bottomShiftCharacterList]
            //self.buttons![0].titleLabel!.text = topShiftCharacterList[0]
            createKeyBoard()
        }
        else if(label == "##")
        {
            CharacterList = [topCharacterList,upperCharacterList,footerCharacterList,bottomCharacterList]
            createKeyBoard()
        }
        else if(label == "###")
        {
            CharacterList = [topCharacterList,upperCharacterList,footerCharacterList,bottomCharacterList]
            createKeyBoard()
        }
        else if(label == "@@")
        {
            advanceToNextInputMode()
        }
        else if(label == "123")
        {
            CharacterList = [topNumberList,upperNumberList,footerNumberList,bottomNumberList]
            createKeyBoard()
        }
        else if(label == "#+=")
        {
            CharacterList = [topSymbolList,upperSymbolList,footerSymbolList,bottomSymbolList]
            createKeyBoard()
        }
        else if(label == "ABC")
        {
            CharacterList = [topCharacterList,upperCharacterList,footerCharacterList,bottomCharacterList]
            createKeyBoard()
        }
        else
        {
            self.textDocumentProxy.insertText(label!)
            let shiftBtn:UIButton = self.view.subviews[19] as! UIButton
            if(shiftBtn.titleLabel?.text=="##")
            {
                CharacterList = [topCharacterList,upperCharacterList,footerCharacterList,bottomCharacterList]
                createKeyBoard()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
    }

}
