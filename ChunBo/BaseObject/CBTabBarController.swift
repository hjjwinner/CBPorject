 //
//  CBTabBarController.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/2.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import Foundation
import UIKit

class CBTabBarController: UITabBarController{
 
    let compblock :(NSData,NSError) ->Void = { (data ,error)in
        
    }
    
    var CBtabBar :UIView = UIView(frame: CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49))
    var barImageArray:NSMutableArray = []
    var barLabelArray:NSMutableArray = []
    
    override func viewDidLoad() {
        self.buildData()
        self.buildUI()
        
    }
    
    func buildData(){
        
        var muarray = NSMutableArray()
        
        for intdex in 1...5{
            var VC = UIViewController()
            if intdex%2 == 1{
                if intdex == 1{
                    VC = ViewController()
                }else{
                    VC.view.backgroundColor = UIColor.grayColor()
                }
                
            }else{
                VC.view.backgroundColor = UIColor.greenColor()
            }
            
            let naV = UINavigationController()
            
            if intdex == 1{
                naV.addChildViewController(VC)
                
            }else{
                naV.addChildViewController(VC)
                
            }
            let imag = UIImage()
            var str:NSString = "\(intdex)";
            var strr = String()
            strr.isEmpty
            
            naV.tabBarItem = UITabBarItem(title: str as String, image:imag, tag: intdex)
            
            muarray.addObject(naV)
            
        }
        
        self.viewControllers = muarray as [AnyObject];
    }
    
    
    func buildUI(){
        self.tabBar.hidden = true;
        self.view.backgroundColor = UIColor.whiteColor()
        
        CBtabBar.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(CBtabBar)
        
        var lineView :UIView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 1))
        lineView.backgroundColor = RGBA(153, 153, 153, 1)
        CBtabBar.addSubview(lineView)
        
        var items : NSArray = self.viewControllers!
        
        var images = ["home_tabbar_home",
            "home_tabbar_classify",
            "home_tabbar_discover",
            "home_tabbar_shoppingCar",
            "home_tabbar_profile"]
        
        var selectImages = ["home_tabbar_home_selected",
            "home_tabbar_classify_selected",
            "home_tabbar_discover_selected",
            "home_tabbar_shoppingCar_selected",
            "home_tabbar_profile_selected"]
        
        var itemName = ["首页","分类","美食","购物车","我的春播"]
        
        for (index , item) in enumerate(items) {
            
            let itemWith :Int = Int(ScreenWidth)/items.count
            
            var itemRect : CGRect = CGRectMake(CGFloat( itemWith * index), CGFloat(0),CGFloat( itemWith), CGFloat(CBtabBar.bounds.height))
            
            
            var barItem = self.barItemCreat(index, imageName: images[index], selectImageName: selectImages[index], titleName: itemName[index], itemFram: itemRect)
            
            barItem.addTarget(self, action:"barItemClick:", forControlEvents: UIControlEvents.TouchUpInside)
            
            CBtabBar.addSubview(barItem)
            
        }
        /**
        默认选中第一个
        
        :returns: <#return value description#>
        */
        self.changeItemState(0)
    }
    
    func barItemCreat(barTag:Int , imageName:String , selectImageName:String ,titleName:String,itemFram:CGRect)->UIButton{
        var barItem :UIButton = UIButton(frame: itemFram)
        barItem.tag = barTag
        var itemImage :UIImageView = UIImageView(frame: CGRectMake(CGFloat((itemFram.width - 30)/2), 5 , 30, 25))
        itemImage.image = UIImage(named: imageName)
        itemImage.highlightedImage = UIImage(named: selectImageName)
        barItem.addSubview(itemImage)
        barImageArray.addObject(itemImage)
        
        var label: UILabel = UILabel(frame: CGRectMake(0, itemFram.height - 20, itemFram.width, 20))
        label.text = titleName
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = RGBA(153, 153, 153, 1)
        label.highlightedTextColor = RGBA(43, 188, 106, 1)
        barItem.addSubview(label)
        barLabelArray.addObject(label)
        
        return barItem;
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        print("\(item)\n");
    }
    
    
    func barItemClick(barItem:UIButton){
        self.selectedIndex = barItem.tag
        self.changeItemState(barItem.tag)
    }

    func changeItemState(index:Int){
        
        for (number,item) in enumerate(barImageArray)  {
            var itemImage :UIImageView = item as! UIImageView;
            if number == index{
                itemImage.highlighted = true
            }else{
                itemImage.highlighted = false
            }
        }
        
        for (number,item) in enumerate(barLabelArray)  {
            var itemLabel :UILabel = item as! UILabel;
            if number == index{
                itemLabel.highlighted = true
            }else{
                itemLabel.highlighted = false
            }
        }
    }
    
    
    
}