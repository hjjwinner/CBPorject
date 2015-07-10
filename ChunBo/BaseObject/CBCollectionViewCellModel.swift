//
//  CBCollectionViewCellModel.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/9.
//  Copyright (c) 2015年 chunbo. All rights reserved.
//

import UIKit

class CBCollectionViewCellModel: NSObject {
    var cellIdentifier:String?
    var cellEdgeInstes:UIEdgeInsets?
    var cellSize:CGSize?
    var userInfor:NSDictionary?    
}


class OneProductCollectionViewCellModel: CBCollectionViewCellModel {
    var title:String?
}