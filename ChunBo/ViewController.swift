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
        
        let list_lc :NSArray = data.objectForKey("data")?.objectForKey("list_lc") as! NSArray
        
        for (index ,obj ) in enumerate(list_lc){
            
            var listLcArray :NSMutableArray = []

            let list :NSArray = obj.objectForKey("list") as! NSArray
            
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
        
//        Alamofire.request(.POST, "http://api.chunbo.com/Home/newindex", parameters: nil).responseJSON{(request, response, JSON, error) in
//            var homeData :NSMutableDictionary = self.buildData(JSON as! NSDictionary) as! NSMutableDictionary
//            self.collection.collectionItemDict = homeData
//
//        }
        
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
        
        
    }
    
    func CBcollectionView(collectionView: UICollectionView, indexPath: NSIndexPath, data: NSDictionary) -> UICollectionViewCell {
        
        let model : CBCollectionViewCellModel = data.objectForKey("\(indexPath.section)")?.objectAtIndex(indexPath.row) as! CBCollectionViewCellModel
        
        let identifier :NSString = model.cellIdentifier!
        
        if identifier.isEqualToString("OneProductCollectionViewCell"){
            
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier as String, forIndexPath: indexPath) as!  OneProductCollectionViewCell
            cell.cellData = model as? OneProductCollectionViewCellModel
            
            return cell
            
            
        }else{
            let identify:String = "ViewCell"
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                identify, forIndexPath: indexPath) as! UICollectionViewCell
            
            cell.backgroundColor = UIColor.yellowColor()
            return cell
        }
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

