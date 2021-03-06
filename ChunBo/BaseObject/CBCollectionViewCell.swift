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
/**
*  @author 黄俊杰, 15-07-11 01:07:50
*
*  @brief  单品页Cell
*/
class OneProductCollectionViewCell: CBCollectionViewCell {
    
    var imageView:UIImageView?
    var titleLabel:UILabel?
    var numberLabel:UILabel?
    var price:UILabel?
    var suTitle:UILabel?
    var originalPrice:CustomLineLabel?
    var placeHold_back:UIImageView?
    var carBtn :cartByButton?
    var imageSale:UIImageView?
    var givenImage:UIImageView?
    
    
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
        
        self.carBtn = cartByButton.ShoppingCart(CGSizeMake(24, 24))
        self.addSubview(carBtn!)
        
        self.imageSale = UIImageView(frame: CGRectMake(10, 10, 60, 20))
        self.imageSale?.hidden = true
        self.addSubview(imageSale!)
        
        self.givenImage = UIImageView(frame: CGRectMake(10, 10, 12, 12))
        self.givenImage?.hidden = true
        self.addSubview(givenImage!)
    }

    override func layoutSubviews() {
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = RGBA(235, 238, 242, 1).CGColor
        
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
        self.price?.textColor = cellData!.priceColor() as UIColor
        self.price?.text = cellData!.priceValue() as String
        self.price?.sizeToFitSize()
        self.price?.snp_makeConstraints({ (make) -> Void in
            make.top.equalTo(self.numberLabel!.snp_bottom).offset(speasd)
            make.left.equalTo(self.numberLabel!.snp_left).offset(0)
        })


        self.originalPrice?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(self.price!)
            make.height.equalTo(15)
            make.left.equalTo(self.price!.snp_right).offset(3)
            make.centerY.equalTo(self.price!.snp_centerY).offset(0)
        })
        self.originalPrice?.text = cellData!.originalPriceValue() as String
        var originalPriceStr :NSString = cellData!.originalPriceValue() as String
        if (originalPriceStr.intValue == 0){
            self.originalPrice?.hidden = true
        }
        self.originalPrice?.textAlignment = NSTextAlignment.Left
        self.originalPrice?.font = UIFont.systemFontOfSize(11)
        self.originalPrice?.textColor = RGBA(153, 153, 153, 1)
        
        self.carBtn?.snp_makeConstraints({ (make) -> Void in
            make.width.height.equalTo(24*percent)
            make.right.lessThanOrEqualTo(self.snp_right).offset(-speasd)
            make.bottom.equalTo(self.snp_bottom).offset(-speasd)
            
        })
        self.carBtn?.addTarget(self, action: "carBtnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let productId = self.cellData?.productId.toInt()
        
        self.carBtn?.remindNumber?.badgeValue = "\(CBUser.shareInstance.getCommodityNumberWithProductId(productId!))"
        
        
        if cellData?.saleImageWithImage() as! NSObject != NSNull(){
            self.imageSale?.image = cellData?.saleImageWithImage() as? UIImage
            self.imageSale?.hidden = false
        }else{
            self.imageSale?.hidden = true
        }
        
    }
    
    
    func carBtnClick(btn : UIButton){
        
        self.carBtn?.imageRingBeRing()
        
        var session_id : String  = NSUserDefaults.standardUserDefaults().stringForKey(sessionID)!
        
        var params : NSDictionary = [
            "product_id":cellData!.productId as String,
            "sku_num":"1",
            "session_id":session_id as String
        ]
        
        CBAPIHelperCart.shareInstance.api_addToCart_withParams(params, completion: { (finished, error) -> Void in
            
            CBUser.shareInstance.getUserCartList({ () -> Void in
                self.layoutSubviews()
            })

        })
    }
    
    
}


class TopBannerCell: CBCollectionViewCell {
    
    var TitleImage : UIImageView?
    var titleLabel : UILabel?
    var letLine : UIImageView?
    var rightLine : UIImageView?
    var cellData : TopBannerCellModel?{
        willSet(newValue){
            self.cellData = newValue
            layoutSubviews()
        }
    }
    
    let margin = 12

    
    convenience  required  init(coder aDecoder: NSCoder) {
        
        self.init(frame:CGRectMake(0, 0, 0 , 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRectMake(0, 0, 300*percent, 174*percent)
        self.backgroundColor = UIColor.clearColor()
        self.creatTheUI()
        
    }
    
    
    func creatTheUI(){
        
        self.titleLabel = UILabel()
        self.addSubview(titleLabel!)
        
        TitleImage = UIImageView()
        self.addSubview(TitleImage!)
        
        self.letLine = UIImageView()
        self.addSubview(letLine!)
        
        self.rightLine = UIImageView()
        self.addSubview(rightLine!)
        
    }
    
    
    override func layoutSubviews() {
  
        self.titleLabel?.text = cellData?.name
        self.titleLabel?.sizeToFitSize()
        self.titleLabel?.snp_makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(self.snp_top).offset(5)
        })
        
        self.letLine?.backgroundColor = RGBA(153, 153, 153, 1)
        self.letLine?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(1)
            make.centerY.equalTo(self.titleLabel!.snp_centerY)
            make.right.equalTo(self.titleLabel!.snp_left).offset(-5)
        })
        
        
        self.rightLine?.backgroundColor = RGBA(153, 153, 153, 1)
        self.rightLine?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(40)
            make.height.equalTo(1)
            make.centerY.equalTo(self.titleLabel!.snp_centerY)
            make.left.equalTo(self.titleLabel!.snp_right).offset(5)
        })
        
        self.TitleImage?.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(self.snp_width)
            make.height.equalTo(139*percent)
            make.top.equalTo(titleLabel!.snp_bottom).offset(10)
            make.bottom.equalTo(self.snp_bottom)
        })
        
        self.TitleImage?.loadImageFromURLString(cellData!.pic!, placeholderImage: nil, completion: { (finished, error) -> Void in
            
        })
    }
    
}


class SpecialCollectionViewCell: CBCollectionViewCell ,CirCleViewDelegate{
    
    var adView : AdView!
    
    var cellData : SpecialCollectionViewCellModel?{
        willSet(newValue){
            self.cellData = newValue
        }
        
        didSet{
            self.cellDataArray.removeAll(keepCapacity: true)
            for (index , obj) in enumerate(self.cellData!.adViewArray!){
                
                var specialModel : SpecialCollectionViewCellModel = obj as! SpecialCollectionViewCellModel
                
                self.cellDataArray.append(specialModel.pic_url!)
            }
            layoutSubviews()
        }
        
    }
    
    var cellDataArray : [String]!{
    
        willSet(newValue){
            self.cellDataArray = newValue
        }
        
        didSet{
            

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        creatTheUI()
    }
    
    func creatTheUI(){
        self.cellDataArray = [String]()
        self.adView = AdView(frame: self.bounds)
        self.adView.delegate = self
        self.addSubview(adView)
        
    }
    
    
    override func layoutSubviews() {
        
        self.adView.imageUrlArray = self.cellDataArray
        
    }
    
    func clickCurrentImage(currentIndxe: Int) {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class bestRCollectionViewCell: CBCollectionViewCell ,UIScrollViewDelegate{
    
    var bastTitleLabel:UILabel?
    var scrlloView:UIScrollView?
    var pageControl:UIPageControl?
    var cellData:bestRCollectionViewCellModel?{
        willSet(newValue){
            self.cellData = newValue
            creatTheUI()
        }
    }
    
    convenience  required  init(coder aDecoder: NSCoder) {
        
        self.init(frame:CGRectMake(0, 0, 0 , 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRectMake(0, 0, ScreenWidth, 154*percent)
        self.backgroundColor = UIColor.whiteColor()
        self.clipsToBounds = true
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = RGBA(235, 238, 242, 1).CGColor
        
        bastTitleLabel = UILabel(frame: CGRectMake(0, 0, 100, 20))
        self.addSubview(bastTitleLabel!)
        bastTitleLabel?.text = "好货推荐"
        bastTitleLabel?.snp_makeConstraints({ (make) -> Void in
            make.centerX.equalTo(self.snp_centerX)
            make.top.equalTo(self.snp_top).offset(10)
        })
        
        var line = UIView(frame: CGRectMake(0, 35, ScreenWidth, 1))
        line.backgroundColor = RGBA(235, 238, 242, 1)
        self.addSubview(line)
        
        self.pageControl = UIPageControl(frame: CGRectMake(0, 0, 20 * CGFloat(1), 20))
        pageControl!.hidesForSinglePage = true
        pageControl?.pageIndicatorTintColor = RGBA(135, 135, 135, 1)
        pageControl?.currentPageIndicatorTintColor = RGBA(213, 213, 213, 1)
        pageControl!.backgroundColor = UIColor.clearColor()
        self.addSubview(self.pageControl!)
        
    }
    
    
    
    func creatTheUI(){
        if (self.scrlloView != nil) {
            self.scrlloView?.removeFromSuperview()
        }
        
        self.scrlloView = UIScrollView(frame: CGRectMake(0, 40, ScreenWidth, self.frame.height - 40))
        scrlloView?.delegate = self
        self.addSubview(scrlloView!)

        scrlloView?.pagingEnabled = true
        scrlloView?.bounces = false
        scrlloView?.showsHorizontalScrollIndicator = false
        let array = cellData?.bestArray

        for (index ,obj ) in enumerate(array!){
            
            var viewBest = creatTheBestView(obj as! bestRCollectionViewCellModel,index: index)
   
        }
        
        scrlloView?.contentSize = CGSizeMake(ScreenWidth*CGFloat(array!.count), scrlloView!.frame.size.height)
        
        
        self.pageControl!.numberOfPages = array!.count
        self.pageControl!.frame = CGRectMake((ScreenWidth - (20 * CGFloat(array!.count)))/2, self.frame.origin.y , 20 * CGFloat(array!.count), 20)
        self.bringSubviewToFront(self.pageControl!)
    }
    
    func creatTheBestView(model:bestRCollectionViewCellModel,index : Int) -> UIView{
        
        var bestView = UIView(frame: CGRectMake(CGFloat(index) * ScreenWidth, 0, ScreenWidth, scrlloView!.frame.size.height))
        scrlloView?.addSubview(bestView)
        
        var image :UIImageView = UIImageView(frame: CGRectMake(20*percent, 10*percent, 100*percent, 80*percent))
        bestView.addSubview(image)
        image.loadImageFromURLString(model.url!, placeholderImage: nil) { (finished, error) -> Void in
        }
        
        image.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(bestView.snp_left).offset(20*percent)
            make.top.equalTo(bestView.snp_top).offset(10*percent)
            make.width.equalTo(100*percent)
            make.height.equalTo(80*percent)
        }
        
        var labelTitle :UILabel = UILabel()
        labelTitle.text = model.title
        labelTitle.sizeToFitSize()
        bestView.addSubview(labelTitle)
        
        labelTitle.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(image.snp_right).offset(20*percent)
            make.top.equalTo(bestView.snp_top).offset(10*percent)
        }
        
        var labelSu :UILabel = UILabel()
        labelSu.text = model.des
        labelSu.textColor = RGBA(153, 153, 153, 1)
        labelSu.sizeToFitSize()
        bestView.addSubview(labelSu)
        
        labelSu.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(image.snp_right).offset(20*percent)
            make.top.equalTo(labelTitle.snp_bottom).offset(3*percent)
        }
        
        var labelNu :UILabel = UILabel()
        labelNu.text = model.specifications
        labelNu.textColor = RGBA(153, 153, 153, 1)
        labelNu.sizeToFitSize()
        bestView.addSubview(labelNu)
        
        labelNu.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(image.snp_right).offset(20*percent)
            make.top.equalTo(labelSu.snp_bottom).offset(3*percent)
        }
        
        var chunboPriceLabel : UILabel = UILabel()
        chunboPriceLabel.text = "¥" + model.chunbo_price!
        chunboPriceLabel.textColor = model.priceColor()
        chunboPriceLabel.sizeToFitSize()
        bestView.addSubview(chunboPriceLabel)
        
        chunboPriceLabel.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(image.snp_right).offset(20*percent)
            make.top.equalTo(labelNu.snp_bottom).offset(3*percent)
        }
        
        
        var marketPriceLabel:CustomLineLabel = CustomLineLabel()
        marketPriceLabel.text = "¥\(model.market_price!)"
        marketPriceLabel.textColor = RGBA(153, 153, 153, 1)
        bestView.addSubview(marketPriceLabel)
        marketPriceLabel.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(chunboPriceLabel.snp_right).offset(5)
            make.top.equalTo(labelNu.snp_bottom).offset(3*percent)
        }
        if model.market_price?.toInt() == 0{
            marketPriceLabel.hidden = true
        }else{
            marketPriceLabel.hidden = false
        }
        
        
        var carBtn : cartByButton = cartByButton.ShoppingCart(CGSizeMake(24, 24))
        bestView.addSubview(carBtn)
        
        carBtn.snp_updateConstraints { (make) -> Void in
            make.left.equalTo(marketPriceLabel.snp_right).offset(15*percent)
            make.centerY.equalTo(marketPriceLabel.snp_centerY).offset(0)
        }
        
        return bestView
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        self.pageControl!.currentPage = Int(scrollView.contentOffset.x/ScreenWidth)
        
    }
    
    
}
