//
//  Baserequest.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit


// MARK: - 基础模型
class BaseModel: NSObject,NSCoding {
    var imageurls:[[String:AnyObject]]?  // 图片数组
    var link:String!  // 网页链接
    var pubDate:String!  // 发布日期
    var source:String!    // 发布来源
    var title:String!   // 发布标题
    var desc:String!     // 文章描述

    // MARK: - 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imageurls, forKey: "imageurls")
        aCoder.encode(link, forKey: "link")
        aCoder.encode(pubDate, forKey: "pubDate")
        aCoder.encode(source, forKey: "source")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(desc, forKey: "desc")
    }
    //MARK: - 解档
    required init?(coder aDecoder: NSCoder) {
        self.imageurls = aDecoder.decodeObject(forKey: "imageurls") as? [[String:AnyObject]]
        self.link = aDecoder.decodeObject(forKey: "link") as? String
        self.pubDate = aDecoder.decodeObject(forKey: "pubDate") as? String
        self.source = aDecoder.decodeObject(forKey: "source") as? String
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.desc = aDecoder.decodeObject(forKey: "desc") as? String

    }

    override init() {
        super.init()
    }
    class func modelWithDic(dic:[String:AnyObject]) ->BaseModel {
        let model = BaseModel()
        model.imageurls = dic["imageurls"] as? [[String:AnyObject]]
        model.link = dic["link"] as! String
        model.pubDate = dic["pubDate"] as! String
        model.source = dic["source"] as! String
        model.title = dic["title"] as! String
        model.desc = dic["desc"] as! String
        return model
    }




}


extension BaseModel{

    // MARK: - 归档






}






















class Baserequest: NSObject {

}
