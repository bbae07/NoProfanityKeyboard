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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

