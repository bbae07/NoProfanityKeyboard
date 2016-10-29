//
//  ViewController.swift
//  NoProfanityKeyboard
//
//  Created by 이경문 on 2016. 8. 13..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ScoreProtocol {

    var scoreBoardView:ScoreBoard?
    var stat_view:UITableView?

    func reloadScore() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreBoardView = ScoreBoard(frame:CGRect(x:0,y:CGFloat(self.navigationController!.navigationBar.frame.size.height),width: UIScreen.main.bounds.size.width,height:310.0))
        self.scoreBoardView?.delegate = self
        self.view.addSubview(self.scoreBoardView!)


        let tableViewStartingY = CGFloat(self.scoreBoardView!.frame.origin.y+self.scoreBoardView!.bounds.size.height)
        self.stat_view = UITableView(frame:CGRect(x:0,y:tableViewStartingY,width:UIScreen.main.bounds.size.width,height:UIScreen.main.bounds.size.height - tableViewStartingY))
        self.view.addSubview(self.stat_view!)

        self.tabBarController?.navigationItem.title = "No Profanity Keyboard"

        self.stat_view!.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "identifier")
        self.stat_view!.allowsSelection = false
        self.stat_view?.bounces = false
        self.stat_view!.delegate = self
        self.stat_view!.dataSource = self

        let Nam1BarBtnVar = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(Nam1BarBtnKlkFnc(_:)))
        self.navigationItem.setRightBarButtonItems([Nam1BarBtnVar], animated: true)

        SVProgressHUD.dismiss()
    }

    func Nam1BarBtnKlkFnc(_ BtnPsgVar: UIBarButtonItem)
    {
        NSLog("Nam1BarBtnKlk")
        //reloadScore()
        SVProgressHUD.show()

        self.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((Manager.defaults?.object(forKey: "swear") as! [AnyObject]).count)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! CustomCell
        let swears:[String] = Manager.defaults!.array(forKey: "swear") as! [String]

        var x = Manager.defaults!.array(forKey: swears[(indexPath as NSIndexPath).row]) as! [AnyObject?]
        cell.swearStr = swears[(indexPath as NSIndexPath).row]
        cell.noStr = (x[1] as! NSNumber).stringValue
        //(x[0] as! [AnyObject])[3] as! Double
        cell.yesStr = ((x[0] as! [AnyObject])[3]).stringValue//((x[0] as! [AnyObject])[3] as! NSNumber).stringValue
        
        if((indexPath as NSIndexPath).row%2 == 1)
        {
            cell.backgroundColor = UIColor(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 0.7)
        }else{
            cell.backgroundColor = UIColor.white
        }
        // Configure the cell...
        cell.awakeFromNib()
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let header = UIView()
        // Dequeue with the reuse identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier") as! CustomCell
        
        cell.swearStr = "WORDS"
        cell.noStr = "USED"
        cell.yesStr = "CHANGED"
        cell.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40.0)
        cell.backgroundColor = UIColor(red: 180.0/255.0, green: 181.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        cell.swear.textColor = UIColor.white
        cell.noChange.textColor = UIColor.white
        cell.yesChange.textColor = UIColor.white
        cell.Line1.backgroundColor = UIColor.white
        cell.Line2.backgroundColor = UIColor.white
        header.addSubview(cell)
        
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

