//
//  BaseAPIHelper.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/11.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit
import Alamofire

class BaseAPIHelper: NSObject {
//    var completion: ((finished: Bool, error: NSError!) -> Void)?
    var APIcompletion: ((finished: AnyObject!, error: NSError!) -> Void)?

    
    
    
    final internal func requestDataFromInterface(
        interface :NSString ,
        withParams params:NSDictionary,
        whithcompletion completion:((finished: AnyObject!, error: NSError!) -> Void)){
            
            self.requestDataFromInterface(interface, withParams: params, withHeaders: [:], withServerURL: baseURL(), HTTPMethod: "POST", whithcompletion: completion)

    }
    
    final func requestDataFromInterface(
        interface :NSString ,
        withParams params:NSDictionary,
        withHeaders headers:NSDictionary,
        withServerURL URL:NSString,
        HTTPMethod method:NSString,
        whithcompletion completion:((finished: AnyObject!, error: NSError!) -> Void)){
        
            
            var requestURL : String = (URL as String) + (interface as String)
            
            Alamofire.request(Method.POST, requestURL, parameters: params as? [String : AnyObject],encoding: ParameterEncoding.URL).responseJSON{(request, response, JSON, error) in
                
                completion(finished: JSON, error: nil)
                
            }
            
    }
    
    func baseURL()->NSString{
        return serverURL
    }
    
    
}
