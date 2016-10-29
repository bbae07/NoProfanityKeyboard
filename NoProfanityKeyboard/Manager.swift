//
//  Manager.swift
//  NoProfanityKeyboard
//
//  Created by Brian Bae on 2016. 8. 21..
//  Copyright © 2016년 이경문. All rights reserved.
//

import Foundation
import UIKit

class Manager{
    static let groupID = "group.chanseobae.npkeyboard"
    static let defaults = UserDefaults(suiteName: groupID)

    

    
    
    class func initWordBank()
    {
        let swears:[String]     = ["fuck","shit","damn","bitch","piss","dick","cock","pussy","asshole","fag","faggot","bastard","slut","douche","cunt","god"]
        let s_count:[NSInteger] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        let array_1 = ["frick" as AnyObject,"fudge" as AnyObject,"frack" as AnyObject, 0 as AnyObject] as [AnyObject]
        let array_2 = ["shoot" as AnyObject,"shucks" as AnyObject,"shite" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_3 = ["darn" as AnyObject,"drat" as AnyObject,"doggon" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_4 = ["biatch" as AnyObject,"" as AnyObject,"" as AnyObject, 0 as AnyObject] as [AnyObject]
        let array_5 = ["ERASE" as AnyObject,"ERASE" as AnyObject,"ERASE" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_6 = ["ERASE" as AnyObject,"ERASE" as AnyObject,"ERASE" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_7 = ["ERASE" as AnyObject,"ERASE" as AnyObject,"ERASE" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_8 = ["ERASE" as AnyObject,"ERASE" as AnyObject,"ERASE" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_9 = ["ERASE" as AnyObject,"ERASE" as AnyObject,"ERASE" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_10 = ["ERASE" as AnyObject,"ERASE" as AnyObject,"ERASE" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_11 = ["ERASE" as AnyObject,"ERASE" as AnyObject,"ERASE" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_12 = ["" as AnyObject,"" as AnyObject,"" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_13 = ["" as AnyObject,"" as AnyObject,"" as AnyObject, 0 as AnyObject] as [AnyObject]
        let array_14 = ["" as AnyObject,"" as AnyObject,"" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_15 = ["" as AnyObject,"" as AnyObject,"" as AnyObject,0 as AnyObject] as [AnyObject]
        let array_16 = ["" as AnyObject,"" as AnyObject,"" as AnyObject, 0 as AnyObject] as [AnyObject]

        let array = [array_1,array_2,array_3,array_4,array_5,array_6,array_7,array_8,
                     array_9,array_10,array_11,array_12,array_13,array_14,array_15,array_16]
        
        for i in 0 ..< swears.count
        {
            Manager.defaults!.set([array[i],s_count[i]], forKey: swears[i])
        }
        Manager.defaults!.set(swears, forKey: "swear")
        Manager.defaults!.synchronize()
    }
    
   
    
    class func allSwears() -> [String]
    {
       return Manager.defaults!.object(forKey: "swear") as! [String]
    }
    
    class func increment(_ swear:String)
    {
        var a = (Manager.defaults!.object(forKey: swear) as! [AnyObject])[1] as! Int
        a += 1
        Manager.defaults!.set([(Manager.defaults!.object(forKey: swear) as! [AnyObject])[0],a as! AnyObject], forKey: swear)
        Manager.defaults!.synchronize()
    }
    
    class func incrementChange(_ swear:String)
    {
        let array = (Manager.defaults!.object(forKey: swear) as! [AnyObject])[0] as! [AnyObject]
        var a = array[3] as! Int
        a += 1
        let new_array = [array[0],array[1],array[2],a] as [Any]
        Manager.defaults!.set([new_array, (Manager.defaults!.object(forKey: swear) as! [AnyObject])[1]], forKey: swear)
        Manager.defaults!.synchronize()
    }
    
    
}
