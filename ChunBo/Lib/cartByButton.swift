//
//  cartByButton.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/10.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit

class cartByButton: UIButton {

    var imageCart:UIImageView?
    var imageRing:UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    class func ShoppingCart()->cartByButton {
        
        var cartBtn : cartByButton = cartByButton.buttonWithType(UIButtonType.Custom) as! cartByButton
        cartBtn.creatThecart()
        
        return cartBtn
    }
    
    func creatThecart(){
        
        imageCart = UIImageView(frame: self.bounds)
        imageCart?.image = UIImage(named: "购物车button")
        self.addSubview(imageCart!)
        imageCart?.center = self.center
        
        imageRing = UIImageView(frame: self.bounds)
        imageRing?.image = UIImage(named: "转圈")
        self.addSubview(imageRing!)
        imageRing?.center = imageCart!.center
        

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
