//
//  ViewController.swift
//  NoProfanityKeyboard
//
//  Created by 이경문 on 2016. 8. 13..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let temp_view = ScoreBoard(frame:CGRect(x:0,y:CGFloat(self.navigationController!.navigationBar.frame.size.height),width: UIScreen.mainScreen().bounds.size.width,height:310.0))
        self.view.addSubview(temp_view)
        
        
        
        let tableViewStartingY = CGFloat(temp_view.frame.origin.y+temp_view.bounds.size.height)
        let stat_view = UITableView(frame:CGRect(x:0,y:tableViewStartingY,width:UIScreen.mainScreen().bounds.size.width,height:UIScreen.mainScreen().bounds.size.height - tableViewStartingY))
        self.view.addSubview(stat_view)

        self.tabBarController?.navigationItem.title = "No Profanity Keyboard"

        stat_view.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "identifier")
        stat_view.allowsSelection = false
        stat_view.delegate = self
        stat_view.dataSource = self

        let Nam1BarBtnVar = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(Nam1BarBtnKlkFnc(_:)))
        self.navigationItem.setRightBarButtonItems([Nam1BarBtnVar], animated: true)
    }

    func Nam1BarBtnKlkFnc(BtnPsgVar: UIBarButtonItem)
    {
        NSLog("Nam1BarBtnKlk")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Manager.defaults!.objectForKey("swear")?.count)!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath) as! CustomCell
        let swears:[String] = Manager.defaults!.arrayForKey("swear") as! [String]

        var x = Manager.defaults!.arrayForKey(swears[indexPath.row]) as! [AnyObject!]
        cell.swearStr = swears[indexPath.row]
        cell.noStr = (x[1] as! NSNumber).stringValue
        cell.yesStr = ((x[0] as! [AnyObject!])[3] as! NSNumber).stringValue
        // Configure the cell...
        cell.awakeFromNib()
        return cell
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        // Dequeue with the reuse identifier
//        let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("identifier") as! CustomCell
//        cell.swearStr = "WORDS"
//        cell.noStr = "SAME"
//        cell.yesStr = "CHANGE"
//        
//        return cell
//    }


}

