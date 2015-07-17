//
//  CBextension.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/10.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        
        if CGSizeEqualToSize(size, CGSizeMake(size.width, CGFloat(MAXFLOAT))) {
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            textSize = self.sizeWithAttributes(attributes as [NSObject : AnyObject])
        } else {
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            let stringRect = self.boundingRectWithSize(size, options: option, attributes: attributes as [NSObject : AnyObject], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}


extension UILabel {
    
    func sizeToFitSize() {
        let textString :NSString = self.text!
//        let stringsize : CGSize = textString.sizeWithAttributes(["NSFontAttributeName":self.font])
        
        let stringsize : CGSize = textString.textSizeWithFont(self.font, constrainedToSize: self.frame.size)

        var rect:CGRect = self.frame
        rect.size = stringsize
        self.frame = rect
        
    }
    
}