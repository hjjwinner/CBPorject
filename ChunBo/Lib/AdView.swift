//
//  AdView.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/15.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit

class AdView: UIView ,UIScrollViewDelegate{

    var contentScrollView: UIScrollView!

    var delegate: CirCleViewDelegate?
    
    var leftImageView :UIImageView?
    var centerImageView :UIImageView?
    var rightImageView :UIImageView?
    var pageControl : UIPageControl?
    var imageNameArray : [UIImage!]!{
        willSet(newValue){
            self.imageNameArray = newValue
        }
        
        didSet{
            self.contentScrollView.scrollEnabled = !(imageNameArray.count == 1)
            self.pageControl!.frame = CGRectMake(self.frame.size.width - 20 * CGFloat(imageNameArray!.count), self.frame.size.height - 30, 20 * CGFloat(imageNameArray!.count), 20)
            self.pageControl?.numberOfPages = self.imageNameArray!.count
            self.reloadImageView()
            
            if (self.moveTime != nil) {
            self.moveTime?.invalidate()
            }
            self.moveTime = NSTimer.scheduledTimerWithTimeInterval(chageImageTime, target: self, selector: "animalMoveImage", userInfo: nil, repeats: true)
        }
    }
    var imageUrlArray : [String]?{
        willSet(newValue){
            self.imageUrlArray = newValue
        }
        
        didSet{
            if imageUrlArray != nil{
            for urlStr in self.imageUrlArray! {
                var urlImage = NSURL(string: urlStr)
                if urlImage == nil { break }
                var dataImage = NSData(contentsOfURL: urlImage!)
                if dataImage == nil { break }
                var tempImage = UIImage(data: dataImage!)
                if tempImage == nil { break }
                imageNameArray.append(tempImage)
            }
            }
        }
    }
    var moveTime :NSTimer?
    var isTimeUp :Bool?
    
    let chageImageTime = 3.0
    var currentImage = 0
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageNameArray = []
        
        self.contentScrollView = UIScrollView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        contentScrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height)
        contentScrollView.delegate = self
        contentScrollView.bounces = false
        contentScrollView.pagingEnabled = true
        contentScrollView.backgroundColor = UIColor.greenColor()
        contentScrollView.showsHorizontalScrollIndicator = false
        self.addSubview(contentScrollView)
        
        leftImageView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        self.contentScrollView.addSubview(leftImageView!)
        centerImageView = UIImageView(frame: CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
        self.contentScrollView.addSubview(centerImageView!)
        var Tap = UITapGestureRecognizer(target: self, action: "imageTapAction:")
        self.centerImageView?.addGestureRecognizer(Tap)
        self.centerImageView?.userInteractionEnabled = true
        rightImageView = UIImageView(frame: CGRectMake(self.frame.size.width*2, 0, ScreenWidth, self.frame.size.height))
        self.contentScrollView.addSubview(rightImageView!)
        
        self.pageControl = UIPageControl(frame: CGRectMake(self.frame.size.width - 20 * CGFloat(1), self.frame.size.height - 30, 20 * CGFloat(1), 20))
        pageControl!.hidesForSinglePage = true
        pageControl!.backgroundColor = UIColor.clearColor()
        self.addSubview(self.pageControl!)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animalMoveImage(){
        self.contentScrollView.setContentOffset(CGPointMake(self.frame.size.width*2, 0), animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
     
        if self.contentScrollView.contentOffset.x == 0{
            
            currentImage = self.getLeftImageIndex(indexOfCurrentImage: currentImage)

        }else if self.contentScrollView.contentOffset.x == self.frame.size.width*2{
            
            currentImage = self.getRightImageIndex(indexOfCurrentImage: currentImage)
            
        }

         
        self.reloadImageView()
        pageControl!.currentPage = currentImage

        self.contentScrollView.setContentOffset(CGPointMake(self.frame.size.width, 0), animated: false)

    }
    
    func reloadImageView(){
        
        leftImageView?.image = imageNameArray![getLeftImageIndex(indexOfCurrentImage: currentImage)] as UIImage

        centerImageView?.image = imageNameArray![currentImage] as UIImage
        
        rightImageView?.image = imageNameArray![getRightImageIndex(indexOfCurrentImage: currentImage)] as UIImage


    }
    
    
    func getLeftImageIndex(indexOfCurrentImage index:Int) -> Int{
        
        var tempIndex = index - 1
        
        if tempIndex == -1{
            return self.imageNameArray!.count - 1
        }else{
            return tempIndex
        }
    }
    
    func getRightImageIndex(indexOfCurrentImage index:Int) -> Int{
        
        var tempIndex = index + 1

        return tempIndex < self.imageNameArray!.count ? tempIndex:0
        
    }
    
    
    func imageTapAction(tap: UITapGestureRecognizer){
        self.delegate?.clickCurrentImage(currentImage)
    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


protocol CirCleViewDelegate {
    /**
    *  点击图片的代理方法
    */
     func clickCurrentImage(currentIndxe: Int)
}

