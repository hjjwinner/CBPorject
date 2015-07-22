//
//  ViewController.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/2.
//

import UIKit
import Alamofire
import SnapKit
import ObjectMapper

class ViewController: UIViewController,CBBaseColletionViewDelegate{
    
    var collection :CBBaseColletionView = CBBaseColletionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
    
    func buildData(data:NSDictionary) -> NSDictionary{
        
        var  homeData : NSMutableDictionary = [:]
        
        
        var topIndex :Int = 0
        
        let list_focus :NSArray = data.objectForKey("data")?.objectForKey("list_focus") as! NSArray

        var FocusArray :NSMutableArray = []

        for (indexFocus ,objFocus ) in enumerate(list_focus){
            
            var FocuslModel : SpecialCollectionViewCellModel = Mapper<SpecialCollectionViewCellModel>().map(objFocus)!
            
            FocusArray.addObject(FocuslModel)
        }
        
        if FocusArray.count > 0{
            
            var SpecialModel : SpecialCollectionViewCellModel = Mapper<SpecialCollectionViewCellModel>().map(data)!
            SpecialModel.cellIdentifier = "SpecialCollectionViewCell"
            SpecialModel.cellEdgeInstes = UIEdgeInsetsMake(0, 0, 0, 0)
            SpecialModel.cellSize = CGSizeMake(ScreenWidth, 120*percent)
            SpecialModel.adViewArray = FocusArray
            
            homeData.setObject([SpecialModel], forKey: "\(topIndex)")
            topIndex++
        }
        
        let best_recommend :NSArray = data.objectForKey("data")?.objectForKey("best_recommend") as! NSArray
        
        var bestArray :NSMutableArray = []
        
        for (indexBest , objBest) in enumerate(best_recommend){
            
            var bestModel :bestRCollectionViewCellModel = Mapper<bestRCollectionViewCellModel>().map(objBest)!
            bestArray.addObject(bestModel)
        }
        
        if bestArray.count > 0{
            
            var bestModel :bestRCollectionViewCellModel = Mapper<bestRCollectionViewCellModel>().map(data)!
            bestModel.cellIdentifier = "bestRCollectionViewCell"
            bestModel.cellEdgeInstes = UIEdgeInsetsMake(10, 0, 0, 0)
            bestModel.cellSize = CGSizeMake(ScreenWidth, 154*percent)
            bestModel.bestArray = bestArray
            
            homeData.setObject([bestModel], forKey: "\(topIndex)")
            topIndex++
        }
        
        let list_lc :NSArray = data.objectForKey("data")?.objectForKey("list_lc") as! NSArray
        
        for (index ,obj ) in enumerate(list_lc){
            
            var listLcArray :NSMutableArray = []

            let list :NSArray = obj.objectForKey("list") as! NSArray
            
            let topDict :NSDictionary = obj.objectForKey("banner1") as! NSDictionary
            
            var topModel : TopBannerCellModel = Mapper<TopBannerCellModel>().map(topDict)!
            
            topModel.cid = obj.objectForKey("cid") as? String
            topModel.name = obj.objectForKey("name") as? String
            topModel.parent_id = obj.objectForKey("parent_id") as? String
            
            topModel.cellIdentifier = "TopBannerCell"
            topModel.cellSize = CGSizeMake(300 * percent, 174 * percent)
            if index == 0{
                topModel.cellEdgeInstes = UIEdgeInsetsMake(0, 10, 0, 10)
            }else{
                topModel.cellEdgeInstes = UIEdgeInsetsMake(10, 10, 0, 10)
            }
            
            listLcArray.addObject(topModel)
            
            for (indexlist ,objlist ) in enumerate(list){
                
                var  OneProductModel : OneProductCollectionViewCellModel = Mapper<OneProductCollectionViewCellModel>().map(objlist)!

                OneProductModel.cellIdentifier = "OneProductCollectionViewCell"
                OneProductModel.cellEdgeInstes = UIEdgeInsetsMake(10, 10, 10, 10)
                OneProductModel.cellSize = CGSizeMake(145*percent, 190*percent)
                
                listLcArray.addObject(OneProductModel)
            }
            
            homeData.setObject(listLcArray, forKey: "\(topIndex)")
            topIndex++
        }
        
        return homeData
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        CBAPIHelperHome.shareInstance.api_newindex_withParams([:], completion: { (finished, error) -> Void in
            var homeData :NSMutableDictionary = self.buildData(finished as! NSDictionary) as! NSMutableDictionary
            self.collection.collectionItemDict = homeData
        })

        self.creatTheUI()
        
        
    }
    
    
    func creatTheUI(){
        
        collection.delegate = self
        self.view.addSubview(collection)
        collection.setCollectionViewBackgroundColor(RGBA(245, 247, 250, 1))
        collection.CBCollectionViewRegisterClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "ViewCell")
        collection.CBCollectionViewRegisterClass(OneProductCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "OneProductCollectionViewCell")
        collection.CBCollectionViewRegisterClass(TopBannerCell.classForCoder(), forCellWithReuseIdentifier: "TopBannerCell")
        collection.CBCollectionViewRegisterClass(SpecialCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "SpecialCollectionViewCell")
        collection.CBCollectionViewRegisterClass(bestRCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "bestRCollectionViewCell")
        
        
    }
    
    func CBcollectionView(collectionView: UICollectionView, indexPath: NSIndexPath, data: NSDictionary) -> UICollectionViewCell {
        
        let model : CBCollectionViewCellModel = data.objectForKey("\(indexPath.section)")?.objectAtIndex(indexPath.row) as! CBCollectionViewCellModel
        
        let identifier :NSString = model.cellIdentifier!
        
        if identifier.isEqualToString("OneProductCollectionViewCell"){
            
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) as!  OneProductCollectionViewCell
            cell.cellData = model as? OneProductCollectionViewCellModel
            
            return cell
            
        }else if identifier.isEqualToString("TopBannerCell"){
            
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) as!  TopBannerCell
            cell.cellData = model as? TopBannerCellModel
            
            return cell

        }else if identifier.isEqualToString("SpecialCollectionViewCell"){
            
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) as!  SpecialCollectionViewCell
            cell.cellData = model as? SpecialCollectionViewCellModel
            
            return cell
            
        }else if identifier.isEqualToString("bestRCollectionViewCell"){
            
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) as!  bestRCollectionViewCell
            cell.cellData = model as? bestRCollectionViewCellModel
            
            return cell
            
        }else{
            let identify:String = "ViewCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                identify, forIndexPath: indexPath) as! UICollectionViewCell
            
            cell.backgroundColor = UIColor.yellowColor()
            return cell
        }
        
    }
    
    func CBcollectionViewdidSelec(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath, withData data:CBCollectionViewCellModel) {
        print("点击了\(indexPath)\(data)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

