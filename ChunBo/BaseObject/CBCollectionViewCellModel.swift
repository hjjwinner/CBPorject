//
//  CBCollectionViewCellModel.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/9.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit
import ObjectMapper

class CBCollectionViewCellModel: NSObject ,Mappable{
    var cellIdentifier:String?
    var cellEdgeInstes:UIEdgeInsets?
    var cellSize:CGSize?
    var userInfor:NSDictionary?
    
    
    override init(){}
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    func mapping(map: Map) {
    }
    
}


class OneProductCollectionViewCellModel: CBCollectionViewCellModel {
    var title:String?
    
    var chunboPrice : String!
    var discountPrice : String!
    var giftName : String!
    var imageId : String!
    var isMain : String!
    var marketPrice : String!
    
    var name : String!{
        willSet(value){
            self.name = value
        }
    }

    var priority : String!
    var productId : String!
    var promoActivityType : String!
    var promoPrice : String!
    var promotionPrice : String!
    var salePrice : String!
    var shortname : String!
    var skuCode : String!
    var specifications : String!
    var stock : Int!
    var stockCount : Int!
    var subname : String!
    var url : String!
    var promoType : [Int]!{
        willSet(newPromoType){
            if newPromoType != nil{
            self.promoType = newPromoType
            }
        }
        
        didSet{
            if promoType != nil {
            for (index,type) in enumerate(promoType){
                if type == 3{
                    self.promo_type3 = true
                }else if type == 4{
                    self.promo_type4 = true
                }else if type == 6{
                    self.promo_type6 = true
                }
            }
            }
        }
  
    }
    var promo_type3: Bool = false
    var promo_type4: Bool = false
    var promo_type6: Bool = false
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        
        chunboPrice	<- map["chunbo_price"]
        discountPrice	<- map["discount_price"]
        giftName	<- map["gift_name"]
        imageId	<- map["image_id"]
        isMain	<- map["is_main"]
        marketPrice	<- map["market_price"]
        name	<- map["name"]
        priority	<- map["priority"]
        productId	<- map["product_id"]
        promoActivityType	<- map["promo_activity_type"]
        promoPrice	<- map["promo_price"]
        promotionPrice	<- map["promotion_price"]
        salePrice	<- map["sale_price"]
        shortname	<- map["shortname"]
        skuCode	<- map["sku_code"]
        specifications	<- map["specifications"]
        stock	<- map["stock"]
        stockCount	<- map["stock_count"]
        subname	<- map["subname"]
        url	<- map["url"]
        promoType	<- map["promo_type"]

        self.titleValue()
        
    }
    
    func titleValue(){
        if name == nil {
            name = subname
        }
    }
    
    
    func priceColor()->UIColor{
        var color = UIColor.redColor()
        
        if promo_type3 {
            color = RGBA(231, 95, 68, 1)
        }else{
            color = RGBA(43, 188, 106, 1)
        }
        
        return color
    }
    
    func priceValue()->NSString{
        
        var value : NSString?
        
        if promoPrice.toInt() != 0 && promo_type3{
            value = promotionPrice
        }else if chunboPrice.toInt() != 0{
            value = chunboPrice
        }else {
            value = marketPrice
        }
        
        return value!
    }
    
    
    func originalPriceValue()->NSString{
        var value : NSString?
        
        if promoPrice.toInt() != 0 && promo_type3{
            value = chunboPrice
        }else if chunboPrice.toInt() != 0{
            value = marketPrice
        }else {
            value = ""
        }
        return value!
    }
    
    func saleImageWithImage()->AnyObject{
        
        var image : UIImage?
        
        if promo_type3 {
            image = UIImage(named: "limitBuy")
        }else if promo_type4 {
            image = UIImage(named: "presell")
        }else{
            return NSNull()
        }
        
        return image! 
    }
    
    
}