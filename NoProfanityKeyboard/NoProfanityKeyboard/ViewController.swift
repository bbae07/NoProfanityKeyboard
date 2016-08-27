//
//  ViewController.swift
//  NoProfanityKeyboard
//
//  Created by 이경문 on 2016. 8. 13..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ScoreProtocol {

    var scoreBoardView:ScoreBoard?
    var stat_view:UITableView?

    func reloadScore() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scoreBoardView = ScoreBoard(frame:CGRect(x:0,y:CGFloat(self.navigationController!.navigationBar.frame.size.height),width: UIScreen.mainScreen().bounds.size.width,height:310.0))
        self.scoreBoardView?.delegate = self
        self.view.addSubview(self.scoreBoardView!)



        let tableViewStartingY = CGFloat(self.scoreBoardView!.frame.origin.y+self.scoreBoardView!.bounds.size.height)
        self.stat_view = UITableView(frame:CGRect(x:0,y:tableViewStartingY,width:UIScreen.mainScreen().bounds.size.width,height:UIScreen.mainScreen().bounds.size.height - tableViewStartingY))
        self.view.addSubview(self.stat_view!)

        self.tabBarController?.navigationItem.title = "No Profanity Keyboard"

        self.stat_view!.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "identifier")
        self.stat_view!.allowsSelection = false
        self.stat_view!.delegate = self
        self.stat_view!.dataSource = self

        let Nam1BarBtnVar = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(Nam1BarBtnKlkFnc(_:)))
        self.navigationItem.setRightBarButtonItems([Nam1BarBtnVar], animated: true)
    }

    func Nam1BarBtnKlkFnc(BtnPsgVar: UIBarButtonItem)
    {
        NSLog("Nam1BarBtnKlk")
        //reloadScore()
        self.viewDidLoad()
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
}

