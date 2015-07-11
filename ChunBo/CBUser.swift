//
//  CBUser.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/12.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit

class CBUser: NSObject {
    
    var session_id : String?
    
   
    class var shareInstance : CBUser {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : CBUser? = nil
        }
        
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = CBUser()
        })
        
        return Static.instance!
    }
    
    func getDefulUsetSessionId(){
        
        
        CBAPIHelperMember().api_AnonymityGetSession_withParams([:], completion: { (finished, error) -> Void in
            
            var sessionDict = finished as! NSDictionary
            
            var flag :NSNumber = sessionDict["flag"]! as! NSNumber
            
            if (flag == 1) {
                
                var sessionId : String = sessionDict["session_id"]! as! String
                
                NSUserDefaults.standardUserDefaults().setObject(sessionId, forKey: sessionID)
                self.session_id = sessionId
                
            }
            
        })
        
    }
    
}
