//
//  CustomLineLabel.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/10.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit

public enum LineType {
    case LineTypeNone//没有画线
    case LineTypeUp // 上边画线
    case LineTypeMiddle//中间画线
    case LineTypeDown//下边画线
    
}

class CustomLineLabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var lineType : LineType = LineType.LineTypeMiddle
    var lineColor :UIColor = UIColor.blackColor()
    
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(rect)
        
        let textString :NSString = self.text!
        
        let stringsize : CGSize = textString.sizeWithAttributes(["NSFontAttributeName":self.font])
        
        let textSize :CGSize = stringsize
        let strikeWidth = textSize.width
        var lineRect:CGRect?
        var origin_x : CGFloat?
        var origin_y : CGFloat = 0.0
        
        lineColor = self.textColor
        
        if self.textAlignment == NSTextAlignment.Right {
            origin_x = rect.size.width - strikeWidth
        }else if self.textAlignment == NSTextAlignment.Center{
            origin_x = (rect.size.width - strikeWidth)/2

        }else if self.textAlignment == NSTextAlignment.Left{
            origin_x = 0
        }
        
        if self.lineType == LineType.LineTypeUp {
            origin_y = 2
        }
        if self.lineType == LineType.LineTypeMiddle {
            origin_y = rect.size.height/2
        }
        if self.lineType == LineType.LineTypeDown {
            origin_y = rect.size.height - 2
        }
        
        lineRect = CGRectMake(origin_x!, origin_y, strikeWidth, 1)
        
        if self.lineType != LineType.LineTypeNone {
            var context = UIGraphicsGetCurrentContext()
            var R,G,B,A : CGFloat?
            
            let uiColor :UIColor = self.lineColor
            var color :CGColorRef = uiColor.CGColor
            var numComponents = CGColorGetNumberOfComponents(color)
            
            if numComponents == 4{
                var components  = CGColorGetComponents(color)
                R = components[0]
                G = components[1]
                B = components[2]
                A = components[3]
                
                CGContextSetRGBFillColor(context, R!, G!, B!, 1.0)
                
            }
            
            CGContextFillRect(context, lineRect!)
        }
        
    }

}
