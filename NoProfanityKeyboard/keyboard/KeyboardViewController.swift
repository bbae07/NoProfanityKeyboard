//
//  KeyboardViewController.swift
//  keyboard
//

import UIKit
import DeviceKit
import FontAwesome_swift

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

    var mainview = UIView()
    
    
    var suggestionView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 40.0))
    
    var Btn_1 = UIButton(frame: CGRect(x:0,y:0,width: (UIScreen.mainScreen().bounds.size.width-3)/3, height:40))
    
    var Line_1 = UIView(frame: CGRect(x: (UIScreen.mainScreen().bounds.size.width-3)/3, y:0, width: 1.5, height: 40))
    
    var Btn_2 = UIButton(frame: CGRect(x:(UIScreen.mainScreen().bounds.size.width-3)/3+1.5,y:0,width: (UIScreen.mainScreen().bounds.size.width-3)/3, height:40))
    
    var Btn_3 = UIButton(frame: CGRect(x:(UIScreen.mainScreen().bounds.size.width-3)/3*2+3,y:0,width: (UIScreen.mainScreen().bounds.size.width-3)/3, height:40))
    var Line_2 = UIView(frame: CGRect(x: (UIScreen.mainScreen().bounds.size.width-3)/3*2+1.5, y:0, width: 1.5, height: 40))

    var keyboardHeight = 176.0 as CGFloat // 184.0 as CGFloat

    var textLength:Int = 0
    var currentText = ""
    
    var currentSwear = ""
    
    func onButtonTap(sender: UIButton) {
        // invoking the delegate when the
        // button is actually tapped
        NSLog("This button was clicked in the subview!")
    }
    
    //Customize Keyboard Height
    
    var heightConstraint: NSLayoutConstraint!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
        if (view.frame.size.width == 0 || view.frame.size.height == 0) {
            return
        }
        
        //setUpHeightConstraint()
    }
    
    
    func setUpHeightConstraint()
    {
        let customHeight = 300.0 as CGFloat
        
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: self.view,
                                                  attribute: .Height,
                                                  relatedBy: .Equal,
                                                  toItem: nil,
                                                  attribute: .NotAnAttribute,
                                                  multiplier: 1,
                                                  constant: customHeight)
            heightConstraint.priority = UILayoutPriority(UILayoutPriorityRequired)
            
            view.addConstraint(heightConstraint)
        }
        else {
            heightConstraint.constant = customHeight
        }
    }

    //Keyboard Height done
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let device = Device()
        if device == .iPhone6Plus{
            NSLog("iPhone6Plus")
            self.keyboardHeight = 184.0 as CGFloat
        }
        
        //Set Dictionary if container app haven't been opened
        
        if(Manager.defaults!.objectForKey("swear") == nil)
        {
            Manager.initWordBank()
        }
        //End
        
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(KeyboardViewController.keyboardShown(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
        mainview.frame = CGRect(x:0,y:40,width: UIScreen.mainScreen().bounds.size.width, height: keyboardHeight)

        createKeyBoard()
        self.view.addSubview(mainview)
        
        Btn_1.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.6)
        Btn_2.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.6)
        Btn_3.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.6)
        Btn_1.setTitleColor(UIColor(red:85.0/255.0, green:85.0/255.0, blue:85.0/255.0, alpha: 1.0), forState: .Normal)
        Btn_2.setTitleColor(UIColor(red:85.0/255.0, green:85.0/255.0, blue:85.0/255.0, alpha: 1.0), forState: .Normal)
        Btn_3.setTitleColor(UIColor(red:85.0/255.0, green:85.0/255.0, blue:85.0/255.0, alpha: 1.0), forState: .Normal)
        Btn_1.addTarget(self, action: #selector(switchWord(_:)), forControlEvents: .TouchUpInside)
        Btn_2.addTarget(self, action: #selector(switchWord(_:)), forControlEvents: .TouchUpInside)
        Btn_3.addTarget(self, action: #selector(switchWord(_:)), forControlEvents: .TouchUpInside)

        Line_1.backgroundColor = UIColor.whiteColor()
        Line_2.backgroundColor = UIColor.whiteColor()
        
        suggestionView.addSubview(Btn_1)
        suggestionView.addSubview(Btn_2)
        suggestionView.addSubview(Btn_3)
        btnReset()
        suggestionView.addSubview(Line_1)
        suggestionView.addSubview(Line_2)
        self.view.addSubview(suggestionView)

    }
    
    override func viewDidAppear(animated: Bool) {
        let expandedHeight:CGFloat = 300
        let heightConstraint = NSLayoutConstraint(item:self.view,
                                                  attribute: .Height,
                                                  relatedBy: .Equal,
                                                  toItem: nil,
                                                  attribute: .NotAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: expandedHeight)
        heightConstraint.priority = 999
        heightConstraint.active = true
        self.view.addConstraint(heightConstraint)
        self.view.updateConstraints()
    }
    
    
    func switchWord(sender:UIButton)
    {
        /*
        currentText : 버튼 눌렀을 때의, 현재까지 입력된 (backward 반영된) 텍스트값
        currentSwear : currentText에 의해 필터
        */
        self.textLength = (self.textDocumentProxy.documentContextBeforeInput?.characters.count)!

        let newStr = currentText.stringByReplacingOccurrencesOfString(currentSwear, withString: sender.titleLabel!.text!)
        for i in 0 ..< currentText.characters.count
        {
           self.textDocumentProxy.deleteBackward()
        }
        self.textDocumentProxy.insertText(newStr)
        self.textLength = 0
        btnReset()
        Manager.incrementChange(currentSwear)
    }

    func btnReset()
    {
        Btn_1.setTitle("", forState:  .Normal)
        Btn_2.setTitle("", forState:  .Normal)
        Btn_3.setTitle("", forState:  .Normal)
        Btn_1.enabled = false
        Btn_2.enabled = false
        Btn_3.enabled = false
    }
    
    
    func keyboardShown(notification: NSNotification) {
        let info  = notification.userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        keyboardHeight = keyboardFrame.size.width - 40
    }
    
    
    func createKeyBoard()
    {
        for subview in mainview.subviews
        {
            subview.removeFromSuperview()
        }
        var y:CGFloat = 0
        for array in CharacterList
        {
            var count:CGFloat = 0
            for member in array
            {
                let Btn = UIButton(frame:CGRect(x:count+CGFloat(10*array.count/(array.count+1)),y:y,width:((UIScreen.mainScreen().bounds.size.width)/CGFloat(array.count))-10,height:keyboardHeight/4))
                Btn.setTitle(member, forState: UIControlState.Normal)
                Btn.backgroundColor = UIColor.whiteColor()
                Btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                Btn.layer.cornerRadius = 5
                Btn.layer.borderWidth = 1
                Btn.layer.borderColor = UIColor.blackColor().CGColor

                if(Btn.titleLabel?.text == "#")
                {
                    let doubleTap:UITapGestureRecognizer = UITapGestureRecognizer()
                    doubleTap.numberOfTapsRequired = 2
                    doubleTap.numberOfTouchesRequired = 1

                    doubleTap.addTarget(self, action: #selector(capsLock(_:)))
                    Btn.addGestureRecognizer(doubleTap)
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.CircleO, textColor: UIColor.blackColor(), size: CGSizeMake(Btn.bounds.size.width, Btn.bounds.size.height)), forState: .Normal)
                }
                if(Btn.titleLabel?.text == "##")
                {
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.Circle, textColor: UIColor.blackColor(), size: CGSizeMake(Btn.bounds.size.width, Btn.bounds.size.height)), forState: .Normal)
                }
                if(Btn.titleLabel?.text == "###")
                {
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.DotCircleO, textColor: UIColor.blackColor(), size: CGSizeMake(Btn.bounds.size.width, Btn.bounds.size.height)), forState: .Normal)
                }
                if (Btn.titleLabel?.text == "@@") {
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.Globe, textColor: UIColor.blackColor(), size: CGSizeMake(Btn.bounds.size.width, Btn.bounds.size.height)), forState: .Normal)
                }
                if (Btn.titleLabel?.text == "<-"){
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.CaretLeft, textColor: UIColor.blackColor(), size: CGSizeMake(Btn.bounds.size.width, Btn.bounds.size.height)), forState: .Normal)
                }

                Btn.addTarget(self, action: #selector(handleBtn(_:)), forControlEvents: .TouchUpInside)

                mainview.addSubview(Btn)
                count += Btn.bounds.size.width+CGFloat(10*array.count/(array.count+1))
            }
            y+=keyboardHeight/4
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
            self.textLength = 0
            btnReset()
        }
        else if(label == "return")
        {
            self.textDocumentProxy.insertText("\n")
            self.textLength = 0
            btnReset()
        }
        else if(label == "<-")
        {
            self.textDocumentProxy.deleteBackward()
        }
        else if(label == "#")
        {
            CharacterList = [topShiftCharacterList,upperShiftCharacterList,footerShiftCharacterList,bottomShiftCharacterList]
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
            let shiftBtn:UIButton = self.mainview.subviews[19] as! UIButton
            if(shiftBtn.titleLabel?.text=="##")
            {
                CharacterList = [topCharacterList,upperCharacterList,footerCharacterList,bottomCharacterList]
                createKeyBoard()
            }
            if self.textDocumentProxy.hasText() {
                checkforSwear(self.textDocumentProxy.documentContextBeforeInput!,length: self.textLength)
            }
        }
    }
    
    func checkforSwear(text:String, length:Int)
    {
        let range = Range(start: text.startIndex.advancedBy(length), end: text.endIndex)
        let subText = text.substringWithRange(range)
        currentText = subText
        
        
        for word in Manager.allSwears()
        {
            if(subText.containsString(word))
            {
                currentSwear = word

                Btn_1.enabled = true
                Btn_2.enabled = true
                Btn_3.enabled = true

                Btn_1.setTitle(((Manager.defaults!.objectForKey(word) as! [AnyObject!])[0] as! [AnyObject!])[0] as! String , forState: .Normal)
                Btn_2.setTitle(((Manager.defaults!.objectForKey(word) as! [AnyObject!])[0] as! [AnyObject!])[1] as! String , forState: .Normal)
                Btn_3.setTitle(((Manager.defaults!.objectForKey(word) as! [AnyObject!])[0] as! [AnyObject!])[2] as! String , forState: .Normal)
                Manager.increment(word)
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
