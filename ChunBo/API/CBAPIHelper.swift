//
//  CBAPIHelper.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/11.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit

let serverURL = "http://api.chunbo.com/"

class CBAPIHelper: BaseAPIHelper {

    
}

/**
*  @author 黄俊杰, 15-07-12 00:07:36
*
*  @brief  公共接口
*/
class CBAPIHelperMember: BaseAPIHelper {
    
    class var shareInstance : CBAPIHelperMember {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : CBAPIHelperMember? = nil
        }
        
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = CBAPIHelperMember()
        })
        
        return Static.instance!
    }
    
    /**
    获取默认用户session_id
    
    :param: params     <#params description#>
    :param: completion <#completion description#>
    */
    func api_AnonymityGetSession_withParams(params : NSDictionary,
        completion:((finished: AnyObject!, error: NSError!) -> Void)
        ){
            requestDataFromInterface("AnonymityGetSession", withParams: params, whithcompletion: completion)
    }
    
    
    override func baseURL()->NSString{
        return serverURL + "Member/"
    }
    
    
}


/**
*  @author 黄俊杰, 15-07-11 23:07:10
*
*  @brief  首页接口
*/
class CBAPIHelperHome: BaseAPIHelper {
    
    class var shareInstance : CBAPIHelperHome {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : CBAPIHelperHome? = nil
        }
        
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = CBAPIHelperHome()
        })
        
        return Static.instance!
    }
    
    
    func api_newindex_withParams(params : NSDictionary,
        completion:((finished: AnyObject!, error: NSError!) -> Void)
        ){
            requestDataFromInterface("newindex", withParams: params, whithcompletion: completion)
    }
    
    
    override func baseURL()->NSString{
        return serverURL + "Home/"
    }
    
}


/**
*  @author 黄俊杰, 15-07-11 23:07:59
*
*  @brief  购物车接口
*/
class CBAPIHelperCart: BaseAPIHelper {
    
    class var shareInstance : CBAPIHelperCart {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : CBAPIHelperCart? = nil
        }
        
        dispatch_once(&Static.onceToken, { () -> Void in
            Static.instance = CBAPIHelperCart()
        })
        
        return Static.instance!
    }
    
    
    func api_addToCart_withParams(params : NSDictionary,
        completion:((finished: AnyObject!, error: NSError!) -> Void)
        ){
            requestDataFromInterface("addToCart", withParams: params, whithcompletion: completion)
    }
    
    func api_ChooseProductCart_withParams(params : NSDictionary,
        completion:((finished: AnyObject!, error: NSError!) -> Void)
        ){
            requestDataFromInterface("ChooseProductCart", withParams: params, whithcompletion: completion)

    }
    
    
    override func baseURL()->NSString{
        return serverURL + "Cart/"
    }
    

}

