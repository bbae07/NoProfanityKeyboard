//
//  AppDelegate.swift
//  NoProfanityKeyboard
//
//  Created by 이경문 on 2016. 8. 13..
//  Copyright © 2016년 이경문. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

/*
   기능: 
        1. 통계 (욕 쓴 횟수, 바꾼 횟수) --> 수치, 그래프
        2. 자기 목표 설정 기능
*/

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        if(!NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce"))
        {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
            initWordBank()
        }

        let tabBar      = UITabBarController()
        let statPage    = StatisticVC()
        let graphPage   = GraphVC()

        let controllers:[UIViewController] = [statPage,graphPage]
        tabBar.viewControllers = controllers;
        self.window?.rootViewController = tabBar;
        return true
    }

    func initWordBank()
    {
        let swears:[String]     = ["LKM","BCS","hello"]
        let s_count:[NSInteger] = [0,0,0]
        let array_1 = ["이경문","KyungMoon","Mark", 0]
        let array_2 = ["배찬서","Chanseo","Brian",0]
        let array_3 = ["안녕","Bonjour","",0]
        let array = [array_1,array_2,array_3]

        for i in 0 ..< swears.count
        {
            NSUserDefaults.standardUserDefaults().setObject([array[i],s_count[i]], forKey: swears[i])
        }
        NSUserDefaults.standardUserDefaults().setObject(swears, forKey: "swear")

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

