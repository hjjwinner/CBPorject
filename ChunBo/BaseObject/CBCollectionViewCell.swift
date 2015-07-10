//
//  CBCollectionViewCell.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/9.
//

import UIKit
import KFSwiftImageLoader
import SnapKit

class CBCollectionViewCell: UICollectionViewCell {

}

class OneProductCollectionViewCell: CBCollectionViewCell {
    
    var imageView:UIImageView?
    var titleLabel:UILabel?
    var numberLabel:UILabel?
    var price:UILabel?
    var suTitle:UILabel?
    var originalPrice:CustomLineLabel?
    var placeHold_back:UIImageView?
    var carBtn :cartByButton?
    
    
    var cellData:OneProductCollectionViewCellModel?{
        willSet(newCellData){
            self.cellData = newCellData
            self.layoutIfNeeded()
            self.layoutSubviews()
        }
        
        
    }
    
    let margin = 12
    
    let speasd = 7

  convenience  required  init(coder aDecoder: NSCoder) {
        
        self.init(frame:CGRectMake(0, 0, 0 , 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRectMake(0, 0, 145*percent, 190*percent)
        self.backgroundColor = UIColor.whiteColor()
        self.creatTheUI()
        
    }
    
    
    func creatTheUI(){
        
        self.placeHold_back = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        self.placeHold_back?.image = UIImage(named: "默认图")
        self.addSubview(self.placeHold_back!)
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 145*percent, 106*percent))
        self.addSubview(self.imageView!)
        
        self.titleLabel = UILabel()
        self.addSubview(titleLabel!)
        
        self.suTitle = UILabel()
        self.addSubview(suTitle!)
        
        self.numberLabel = UILabel()
        self.addSubview(numberLabel!)
        
        self.price = UILabel()
        self.addSubview(price!)
        
        self.originalPrice = CustomLineLabel()
        self.addSubview(originalPrice!)
        
        self.carBtn = cartByButton.ShoppingCart()
        self.addSubview(carBtn!)
    }
    
    override func layoutSubviews() {
        
        imageView?.backgroundColor = UIColor.grayColor()
        self.imageView!.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(145*percent)
            make.height.equalTo(106*percent)
            
        })
        
        imageView?.loadImageFromURLString(cellData!.url, placeholderImage:  nil, completion: { (finished, error) -> Void in
            
        })

        self.placeHold_back?.snp_makeConstraints({ (make) -> Void in
            make.center.equalTo(self.imageView!)
            
        })
        
        self.titleLabel?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(self.frame.size.width - 24)
            make.height.equalTo(15)
            make.top.equalTo(self.imageView!.snp_bottom).offset(speasd)
            make.left.equalTo(margin)
            
        })
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.titleLabel?.text = cellData?.name
        
        self.suTitle?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(self.frame.size.width - 24)
            make.height.equalTo(15)
            make.top.equalTo(self.titleLabel!.snp_bottom).offset(speasd)
            make.left.equalTo(self.titleLabel!.snp_left).offset(0)
            
        })
        self.suTitle?.font = UIFont.systemFontOfSize(12)
        self.suTitle?.textColor = RGBA(153, 153, 153, 1)
        self.suTitle?.text = cellData?.subname

        self.numberLabel?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(self.frame.size.width - 24)
            make.height.equalTo(15)
            make.top.equalTo(self.suTitle!.snp_bottom).offset(speasd)
            make.left.equalTo(self.suTitle!.snp_left).offset(0)
            
        })
        self.numberLabel?.textColor = RGBA(153, 153, 153, 1)
        self.numberLabel?.font = UIFont.systemFontOfSize(12)
        self.numberLabel?.text = cellData?.specifications
        
        
        self.price?.font = UIFont.systemFontOfSize(14)
        self.price?.textColor = UIColor.redColor()
        self.price?.text = cellData?.chunboPrice
        self.price?.sizeToFitSize()
        self.price?.snp_makeConstraints({ (make) -> Void in
            make.height.equalTo(15)
            make.top.equalTo(self.numberLabel!.snp_bottom).offset(speasd)
            make.left.equalTo(self.numberLabel!.snp_left).offset(0)
        })


        self.originalPrice?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(self.price!)
            make.height.equalTo(15)
            make.left.equalTo(self.price!.snp_right).offset(3)
            make.centerY.equalTo(self.price!.snp_centerY).offset(0)
        })
        self.originalPrice?.text = cellData?.marketPrice
        self.originalPrice?.textAlignment = NSTextAlignment.Left
        self.originalPrice?.font = UIFont.systemFontOfSize(11)
        self.originalPrice?.textColor = RGBA(153, 153, 153, 1)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = RGBA(235, 238, 242, 1).CGColor
        
        
        self.carBtn?.snp_makeConstraints({ (make) -> Void in
            make.width.height.equalTo(24*percent)
            make.right.lessThanOrEqualTo(self.snp_right).offset(speasd)
            make.bottom.equalTo(self.snp_bottom).offset(speasd)
            
        })
        
    }
    
}

