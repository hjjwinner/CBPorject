//
//  CBCollectionViewCell.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/9.
//

import UIKit

class CBCollectionViewCell: UICollectionViewCell {

}

class OneProductCollectionViewCell: CBCollectionViewCell {
    
    var imageView:UIImageView?
    var titleLabel:UILabel?
    var numberLabel:UILabel?
    var price:UILabel?
    var suTitle:UILabel?
    var originalPrice:UILabel?
    var placeHold_back:UIImageView?
    
    var cellData:OneProductCollectionViewCellModel?{
        willSet(newCellData){
            self.cellData = newCellData
            self.layoutIfNeeded()
            self.layoutSubviews()
        }
        
        
    }
    
    let margin = 12

  convenience  required  init(coder aDecoder: NSCoder) {
        
        self.init(frame:CGRectMake(0, 0, 0 , 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRectMake(0, 0, 145*percent, 190*percent)
        self.backgroundColor = UIColor.yellowColor()
        self.creatTheUI()
        
    }
    
    
    func creatTheUI(){
        
        self.placeHold_back = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        self.placeHold_back?.image = UIImage(named: "默认图")
        self.addSubview(self.placeHold_back!)
        
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 145*percent, 116*percent))
        self.addSubview(self.imageView!)
        
        self.titleLabel = UILabel()
        self.addSubview(titleLabel!)
        
        self.suTitle = UILabel()
        self.addSubview(suTitle!)
        
        self.numberLabel = UILabel()
        self.addSubview(numberLabel!)
        
        self.price = UILabel()
        self.addSubview(price!)
        
        
    }
    
    override func layoutSubviews() {
        
        imageView?.backgroundColor = UIColor.grayColor()
        self.imageView!.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(145*percent)
            make.height.equalTo(116*percent)
            
        })
        
        self.titleLabel?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(self.frame.size.width - 24)
            make.height.equalTo(20)
            make.top.equalTo(self.imageView!.snp_bottom).offset(10)
            make.left.equalTo(margin)
            
        })
        self.titleLabel?.backgroundColor = UIColor.grayColor()
        
        
        
        
        
    }
    
}

