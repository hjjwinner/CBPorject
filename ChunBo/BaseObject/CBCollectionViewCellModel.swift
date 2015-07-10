//
//  CBCollectionViewCellModel.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/9.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit
import ObjectMapper

class CBCollectionViewCellModel: NSObject {
    var cellIdentifier:String?
    var cellEdgeInstes:UIEdgeInsets?
    var cellSize:CGSize?
    var userInfor:NSDictionary?
    
    
}


class OneProductCollectionViewCellModel: CBCollectionViewCellModel, Mappable {
    var title:String?
    
    var chunboPrice : String!
    var discountPrice : String!
    var giftName : String!
    var imageId : String!
    var isMain : String!
    var marketPrice : String!
    var name : String!
    var priority : String!
    var productId : String!
    var promoActivityType : String!
    var promoPrice : String!
    var promoType : [Int]!
    var promotionPrice : String!
    var salePrice : String!
    var shortname : String!
    var skuCode : String!
    var specifications : String!
    var stock : Int!
    var stockCount : Int!
    var subname : String!
    var url : String!
    
    override init(){}
    
    required init?(_ map: Map) {
        super.init()
        
        mapping(map)
    }
    
    func mapping(map: Map) {
        chunboPrice	<- map["chunbo_price"]
        discountPrice	<- map["discount_Price"]
        giftName	<- map["gift_Name"]
        imageId	<- map["image_id"]
        isMain	<- map["isMain"]
        marketPrice	<- map["market_price"]
        name	<- map["name"]
        priority	<- map["priority"]
        productId	<- map["product_id"]
        promoActivityType	<- map["promo_Activity_Type"]
        promoPrice	<- map["promo_Price"]
        promoType	<- map["promo_Type"]
        promotionPrice	<- map["promotionPrice"]
        salePrice	<- map["sale_Price"]
        shortname	<- map["shortname"]
        skuCode	<- map["sku_code"]
        specifications	<- map["specifications"]
        stock	<- map["stock"]
        stockCount	<- map["stock_Count"]
        subname	<- map["subname"]
        url	<- map["url"]
    }
}