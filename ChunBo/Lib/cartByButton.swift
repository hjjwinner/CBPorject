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
    var remindNumber : RemindNumber?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    class func ShoppingCart(frame: CGSize)->cartByButton {
        
        var cartBtn : cartByButton = cartByButton.buttonWithType(UIButtonType.Custom) as! cartByButton
        cartBtn.frame = CGRectMake(0, 0, frame.width*percent, frame.height*percent)
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
        
        remindNumber  = RemindNumber(frame: CGRectMake(self.imageCart!.bounds.width - 15, -5, 5, 5))
        self.addSubview(remindNumber!)

    }
    
    func imageRingBeRing(){
        self.imageRing?.hidden = false
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}



class RemindNumber: UIButton {
    
    var badgeValue :NSString?{
        
        willSet(badge){
            self.badgeValue = badge
            self.changeBadgeValue(badge!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.RemindNumbe()
    }
    
    func RemindNumbe(){
        self.setBackgroundImage(UIImage(named: "main_badge"), forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.titleLabel?.textColor = UIColor.blackColor()
        self.userInteractionEnabled = false
        self.adjustsImageWhenDisabled = false
        self.frame.size = CGSizeMake(20, 20)
        self.hidden = true
    }
    
     func changeBadgeValue(newBadgeValue : NSString){
        
        if newBadgeValue.intValue > 0 &&  newBadgeValue.intValue < 100{
            self.hidden = false
            self.setTitle("\(newBadgeValue)", forState: UIControlState.Normal)
        }else if newBadgeValue.intValue >= 100 {
            self.setTitle("N", forState: UIControlState.Normal)
        }else{
            self.hidden = true
        }
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
