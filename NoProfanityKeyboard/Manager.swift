//
//  Manager.swift
//  NoProfanityKeyboard
//
//  Created by Brian Bae on 2016. 8. 21..
//  Copyright © 2016년 이경문. All rights reserved.
//

import Foundation

class Manager{
    static let groupID = "group.chanseobae.npkeyboard"
    static let defaults = NSUserDefaults(suiteName: groupID)
    
    
    class func initWordBank()
    {
        let swears:[String]     = ["LKM","BCS","hello"]
        let s_count:[NSInteger] = [0,0,0]
        let array_1 = ["이경문","KyungMoon","Mark", 0]
        let array_2 = ["배찬서","Chanseo","Brian",0]
        let array_3 = ["안녕","Bonjour","",0]
        let array = [array_1,array_2,array_3]
        
        for i in 0 ..< swears.count
        {
            Manager.defaults!.setObject([array[i],s_count[i]], forKey: swears[i])
        }
        Manager.defaults!.setObject(swears, forKey: "swear")
        Manager.defaults!.synchronize()
    }
    
    class func allSwears() -> [String]
    {
       return Manager.defaults!.objectForKey("swear") as! [String]
    }
    
    class func increment(swear:String)
    {
        var a = (Manager.defaults!.objectForKey(swear) as! [AnyObject!])[1] as! Int
        a += 1
        Manager.defaults!.setObject([(Manager.defaults!.objectForKey(swear) as! [AnyObject!])[0],a], forKey: swear)
        Manager.defaults!.synchronize()
    }
    
    
}