//
//  ViewController.swift
//  ChunBo
//
//  Created by hjjwinner on 15/7/2.
//

import UIKit
import Alamofire


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
                
                var  OneProductModel : OneProductCollectionViewCellModel = OneProductCollectionViewCellModel()
                
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
        
        Alamofire.request(.POST, "http://api.chunbo.com/Home/newindex", parameters: nil).responseJSON{(request, response, JSON, error) in
            print("\(JSON)");
            var homeData :NSMutableDictionary = self.buildData(JSON as! NSDictionary) as! NSMutableDictionary
            self.collection.collectionItemDict = homeData
            
        }
        
//        Alamofire.request(.POST, "http://httpbin.org/post", parameters: ["add":"aff"], encoding: .JSON(options: nil))
//            .responseJSON {(request, response, JSON, error) in
//                println(JSON)
//        }
        
//        Alamofire.request(.GET,"http://api.chunbo.com/Home/newindex",parameters: ["foo": "bar"]).responseString{(request, response, string, error) in
//            
////            NSDictionary * dict = [NSJSONSerialization .JSONObjectWithData(string, options: NSJSONReadingMutableLeaves, error: nil)];
//            
//        print("\(string)")
//            print("\(response)")
//        }

        self.creatTheUI()
    }
    
    func creatTheUI(){
        
        collection.delegate = self
        self.view.addSubview(collection)
        collection.CBCollectionViewRegisterClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "ViewCell")
        collection.CBCollectionViewRegisterClass(OneProductCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "OneProductCollectionViewCell")
        
        var array:NSArray = ["aa","BB"]
        for (index , value ) in enumerate(array){
            print("\(value)-\(index)")
        }
        var lertter = Set<Character>()
        lertter.insert("a")
        print("\(lertter)")
        lertter.insert("a")
        print("\(lertter)")
        
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
            // 获取设计的单元格，不需要再动态添加界面元素
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                identify, forIndexPath: indexPath) as! UICollectionViewCell
            
            // 图片上面显示课程名称，居中显示
            let lbl = UILabel(frame:CGRectMake(0,5,cell.bounds.size.width,20))
            lbl.textAlignment = NSTextAlignment.Center
            lbl.text = "name"
            cell.addSubview(lbl)
            lbl.backgroundColor = UIColor.greenColor()
            lbl.snp_makeConstraints { (make) -> Void in
                //            make.width.height.equalTo(100)
//                make.top.equalTo(cell.snp_bottom).offset(10)
            }
            cell.backgroundColor = UIColor.yellowColor()
            return cell
        }
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

