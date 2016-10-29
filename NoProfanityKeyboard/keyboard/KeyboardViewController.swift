//
//  KeyboardViewController.swift
//  keyboard
//

import UIKit
import DeviceKit
/*import FontAwesome_swift*/


class KeyboardViewController: UIInputViewController {

    var topCharacterList:[String] = ["q","w","e","r","t","y","u","i","o","p"] // 10개
    var upperCharacterList:[String] = ["a","s","d","f","g","h","j","k","l"] // 9개
    var footerCharacterList:[String] = ["#1","z","x","c","v","b","n","m","<-"] // 9개
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


    lazy var CharacterList: [[String]] = [self.topCharacterList,self.upperCharacterList,self.footerCharacterList,self.bottomCharacterList]

    var mainview = UIView()
    
    
    var suggestionView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 35.0))
    
    var Btn_1 = UIButton(frame: CGRect(x:0,y:0,width: (UIScreen.main.bounds.size.width-3)/3, height:35))
    
    var Line_1 = UIView(frame: CGRect(x: (UIScreen.main.bounds.size.width-3)/3, y:0, width: 1.5, height: 35))
    
    var Btn_2 = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width-3)/3+1.5,y:0,width: (UIScreen.main.bounds.size.width-3)/3, height:35))
    
    var Btn_3 = UIButton(frame: CGRect(x:(UIScreen.main.bounds.size.width-3)/3*2+3,y:0,width: (UIScreen.main.bounds.size.width-3)/3, height:35))
    var Line_2 = UIView(frame: CGRect(x: (UIScreen.main.bounds.size.width-3)/3*2+1.5, y:0, width: 1.5, height: 35))

    var keyboardHeight = 181.0 as CGFloat

    var textLength:Int = 0
    var currentText = ""
    
    var currentSwear = ""
    
    func onButtonTap(_ sender: UIButton) {
        NSLog("This button was clicked in the subview!")
    }
    

    var heightConstraint: NSLayoutConstraint!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        if (view.frame.size.width == 0 || view.frame.size.height == 0) {
            return
        }
    }
    
    
    func setUpHeightConstraint()
    {
        let customHeight = 300.0 as CGFloat
        
        if heightConstraint == nil {
            heightConstraint = NSLayoutConstraint(item: self.view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
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
            self.keyboardHeight = 189.0 as CGFloat
        }
        
        if(Manager.defaults!.object(forKey: "swear") == nil)
        {
            Manager.initWordBank()
        }

        NotificationCenter.default.addObserver(self,selector: #selector(KeyboardViewController.keyboardShown(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        mainview.frame = CGRect(x:0,y:35,width: UIScreen.main.bounds.size.width, height: keyboardHeight)

        createKeyBoard()
        self.view.addSubview(mainview)
        
        Btn_1.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.6)
        Btn_2.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.6)
        Btn_3.backgroundColor = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.6)
        Btn_1.setTitleColor(UIColor(red:85.0/255.0, green:85.0/255.0, blue:85.0/255.0, alpha: 1.0), for: UIControlState())
        Btn_2.setTitleColor(UIColor(red:85.0/255.0, green:85.0/255.0, blue:85.0/255.0, alpha: 1.0), for: UIControlState())
        Btn_3.setTitleColor(UIColor(red:85.0/255.0, green:85.0/255.0, blue:85.0/255.0, alpha: 1.0), for: UIControlState())
        Btn_1.addTarget(self, action: #selector(switchWord(_:)), for: .touchUpInside)
        Btn_2.addTarget(self, action: #selector(switchWord(_:)), for: .touchUpInside)
        Btn_3.addTarget(self, action: #selector(switchWord(_:)), for: .touchUpInside)

        Line_1.backgroundColor = UIColor.white
        Line_2.backgroundColor = UIColor.white
        
        suggestionView.addSubview(Btn_1)
        suggestionView.addSubview(Btn_2)
        suggestionView.addSubview(Btn_3)
        btnReset()
        suggestionView.addSubview(Line_1)
        suggestionView.addSubview(Line_2)
        self.view.addSubview(suggestionView)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let expandedHeight:CGFloat = 300
        let heightConstraint = NSLayoutConstraint(item:self.view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: expandedHeight)
        heightConstraint.priority = 999
        heightConstraint.isActive = true
        self.view.addConstraint(heightConstraint)
        self.view.updateConstraints()
    }
    
    
    func switchWord(_ sender:UIButton)
    {
        self.textLength = (self.textDocumentProxy.documentContextBeforeInput?.characters.count)!

        let newStr = currentText.replacingOccurrences(of: currentSwear, with: sender.titleLabel!.text!)
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
        Btn_1.setTitle("", for:  UIControlState())
        Btn_2.setTitle("", for:  UIControlState())
        Btn_3.setTitle("", for:  UIControlState())
        Btn_1.isEnabled = false
        Btn_2.isEnabled = false
        Btn_3.isEnabled = false
    }
    
    
    func keyboardShown(_ notification: Notification) {
        let info  = (notification as NSNotification).userInfo!
        let value: AnyObject = info[UIKeyboardFrameEndUserInfoKey]! as AnyObject
        
        let rawFrame = value.cgRectValue
        let keyboardFrame = view.convert(rawFrame!, from: nil)
        keyboardHeight = keyboardFrame.size.width - 35
    }
    
    
    func createKeyBoard()
    {
        for subview in mainview.subviews
        {
            subview.removeFromSuperview()
        }
        var y:CGFloat = 2
        for array in CharacterList
        {
            var count:CGFloat = 2
            var count1:CGFloat = 20
            
            for member in array
            {
                var Btn:UIButton = UIButton()
                if(array == CharacterList[0])
                {
                    Btn = UIButton(frame:CGRect(x:count+CGFloat(6*array.count/(array.count+1)),y:y,width:((UIScreen.main.bounds.size.width)/CGFloat(array.count))-6,height:keyboardHeight/4 - 8))
                }
                else if(array == CharacterList[1])
                {
                    if(array[0] == "a" || array[0] == "A")
                    {
                        if(member == array[0])
                        {
                            Btn = UIButton(frame:CGRect(x:20+CGFloat(6*array.count/(array.count+1)),y:y,width:((UIScreen.main.bounds.size.width)/CGFloat(10.0))-6,height:keyboardHeight/4 - 8))
                        }
                            
                        else
                        {
                            Btn = UIButton(frame:CGRect(x:count1+CGFloat(6*array.count/(array.count+1)),y:y,width:((UIScreen.main.bounds.size.width)/CGFloat(10.0))-6,height:keyboardHeight/4 - 8))
                        }
    
                    }
                        
                    else
                    {
                        Btn = UIButton(frame:CGRect(x:count+CGFloat(6*array.count/(array.count+1)),y:y,width:((UIScreen.main.bounds.size.width)/CGFloat(array.count))-6,height:keyboardHeight/4 - 8))
                    }
                    
                }
                else if(array  == CharacterList[2])
                {
                    Btn = UIButton(frame:CGRect(x:count+CGFloat(6*array.count/(array.count+1)),y:y,width:((UIScreen.main.bounds.size.width)/CGFloat(array.count))-6,height:keyboardHeight/4 - 8))
                }
                else if(array == CharacterList[3])
                {
                    if(member == array[0])
                    {
                        Btn = UIButton(frame:CGRect(x:5,y:y,width:(UIScreen.main.bounds.size.width - 20)/8,height:keyboardHeight/4 - 8))
                    }
                    else if(member == array[1])
                    {
                        //padding 3,2,3,3
                        Btn = UIButton(frame:CGRect(x:10+(UIScreen.main.bounds.size.width - 25)/8 ,y:y,width:(UIScreen.main.bounds.size.width - 25)/8,height:keyboardHeight/4 - 8))
                    }
                    else if(member == array[2])
                    {
                        Btn = UIButton(frame:CGRect(x:15+(UIScreen.main.bounds.size.width - 25)/4,y:y,width:(UIScreen.main.bounds.size.width - 25)/2,height:keyboardHeight/4 - 8))
                    }
                    else if(member == array[3])
                    {
                        Btn = UIButton(frame:CGRect(x:20+(UIScreen.main.bounds.size.width - 25)*3/4,y:y,width:(UIScreen.main.bounds.size.width - 25)/4,height:keyboardHeight/4 - 8))
                    }
                }
                
                Btn.setTitle(member, for: UIControlState())
                Btn.backgroundColor = UIColor.white
                Btn.setTitleColor(UIColor.black, for: UIControlState())
                Btn.layer.cornerRadius = 5
                //Btn.layer.borderWidth = 1
                //Btn.layer.borderColor = UIColor.blackColor().CGColor

                /*if(Btn.titleLabel?.text == "#1")
                {

                    Btn.setImage(UIImage.fontAwesomeIconWithName(.CircleO, textColor: UIColor.black, size: CGSize(width: Btn.bounds.size.width, height: Btn.bounds.size.height)), for: UIControlState())
                }
                if(Btn.titleLabel?.text == "##")
                {
                    Btn.addTarget(self, action: #selector(capsLock(_:)), for: .touchDownRepeat)
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.Circle, textColor: UIColor.black, size: CGSize(width: Btn.bounds.size.width, height: Btn.bounds.size.height)), for: UIControlState())
                }
                if(Btn.titleLabel?.text == "###")
                {
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.DotCircleO, textColor: UIColor.black, size: CGSize(width: Btn.bounds.size.width, height: Btn.bounds.size.height)), for: UIControlState())
                }
                if (Btn.titleLabel?.text == "@@") {
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.Globe, textColor: UIColor.black, size: CGSize(width: Btn.bounds.size.width, height: Btn.bounds.size.height)), for: UIControlState())
                    //UIImageIns
                }
                if (Btn.titleLabel?.text == "<-"){
                    Btn.setImage(UIImage.fontAwesomeIconWithName(.CaretLeft, textColor: UIColor.black, size: CGSize(width: Btn.bounds.size.width, height: Btn.bounds.size.height)), for: UIControlState())
                }*/

                Btn.addTarget(self, action: #selector(handleBtn(_:)), for: .touchUpInside)

                mainview.addSubview(Btn)
                count += Btn.bounds.size.width+CGFloat(6*array.count/(array.count+1))
                count1 += Btn.bounds.size.width+CGFloat(6*array.count/(array.count+1))
            }
            y+=keyboardHeight/4
        }
        
    }

    func capsLock(_ sender:UITapGestureRecognizer)
    {
        CharacterList = [topCapCharacterList,upperCapCharacterList,footerCapCharacterList,bottomCapCharacterList]
        createKeyBoard()
    }

    func handleBtn(_ sender:UIButton)
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
        else if(label == "#1")
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
            if self.textDocumentProxy.hasText {
                checkforSwear(self.textDocumentProxy.documentContextBeforeInput!,length: self.textLength)
            }
        }
    }
    
    func checkforSwear(_ text:String, length:Int)
    {
        let range = (text.characters.index(text.startIndex, offsetBy: length) ..< text.endIndex)
        let subText = text.substring(with: range)
        currentText = subText
        
        
        for word in Manager.allSwears()
        {
            if(subText.contains(word))
            {
                currentSwear = word

                Btn_1.isEnabled = true
                Btn_2.isEnabled = true
                Btn_3.isEnabled = true

                Btn_1.setTitle(((Manager.defaults!.object(forKey: word) as! [AnyObject?])[0] as! [AnyObject?])[0] as! String , for: UIControlState())
                Btn_2.setTitle(((Manager.defaults!.object(forKey: word) as! [AnyObject?])[0] as! [AnyObject?])[1] as! String , for: UIControlState())
                Btn_3.setTitle(((Manager.defaults!.object(forKey: word) as! [AnyObject?])[0] as! [AnyObject?])[2] as! String , for: UIControlState())
                Manager.increment(word)
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
    }
    
    

}
