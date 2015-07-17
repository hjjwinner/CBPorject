//
//  CBUser.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/12.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit
import SwiftyJSON

class CBUser: NSObject {
    
    var session_id : String?
    var cartListDict :NSDictionary?
   
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
    
    func getcartNumber()->Int {
    
        var cartNumber :Int = 0
        
        if cartListDict != nil {
            cartNumber = self.cartListDict!["product_num"] as! Int
        }
        return cartNumber
    }
    
    func getCommodityNumberWithProductId(productId : Int) -> Int{
        
        if cartListDict != nil {
            
            var arrayList :NSArray = cartListDict!["product_list"] as! NSArray
            
            for (index ,obj) in enumerate(arrayList){
                
                var dict :NSDictionary = obj as! NSDictionary
                
                var id :String = dict["product_id"] as! String
                
                if id.toInt() == productId{
                    let quantity :String = dict["quantity"] as! String
                    
                    return quantity.toInt()!
                }
            }

        }
        return 0
    }
    
    
    
    
    func getDefulUsetSessionId(){

        CBAPIHelperMember.shareInstance.api_AnonymityGetSession_withParams([:], completion: { (finished, error) -> Void in
            
            var sessionDict = finished as! NSDictionary
//            var see = JSON(finished)
//            var sss = see["flag"].number
            var flag :NSNumber = sessionDict["flag"]! as! NSNumber
            
            if (flag == 1) {
                
                var sessionId : String = sessionDict["session_id"]! as! String
                
                NSUserDefaults.standardUserDefaults().setObject(sessionId, forKey: sessionID)
                self.session_id = sessionId
                
            }
            
        })
        
    }
    
    func getUserCartList(completion:()->Void){
        
        var session_id : String  = NSUserDefaults.standardUserDefaults().stringForKey(sessionID)!

        
        CBAPIHelperCart.shareInstance.api_ChooseProductCart_withParams(["session_id":session_id as String], completion: { (finished, error) -> Void in
            
            var flag :NSNumber = finished["flag"]! as! NSNumber

            
            if flag == 1 {
                self.cartListDict = finished as? NSDictionary
                completion()
//  NSNotificationCenter.defaultCenter().postNotificationName(CBCollectionViewReload, object: nil)
            }
            
        })
    }
    
    
}
