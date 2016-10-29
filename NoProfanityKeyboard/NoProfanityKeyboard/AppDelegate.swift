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

    @objc func resetData()
    {
        //        let notification = UILocalNotification()
        //        notification.alertTitle = "Weekly Update"
        //        notification.alertBody = "No Profanity Keyboard has just been refreshed"
        //NSLog("Timer Works")
        Manager.initWordBank()
        //UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        var timer = Timer.scheduledTimer(timeInterval: 1209600.0, target: self, selector: #selector(AppDelegate.resetData), userInfo: nil, repeats: true)
        

        // Override point for customization after application launch.

        
        
        if(!UserDefaults.standard.bool(forKey: "HasLaunchedOnce"))
        {
            if(Manager.defaults!.object(forKey: "swear") == nil)
            {
                Manager.initWordBank()
                UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            }
        }
        
        let viewPage = ViewController()
        let nav = UINavigationController.init(rootViewController: viewPage)

        nav.navigationBar.topItem?.title = "No Profanity Keyboard"

        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        nav.navigationItem.rightBarButtonItem = search
        
        self.window?.rootViewController = nav;
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

