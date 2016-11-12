//
//  Baserequest.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit


// MARK: - 基础模型
class BaseModel: NSObject {
    var imageurls:[[String:AnyObject]]?  // 图片数组
    var link:String!  // 网页链接
    var pubDate:String!  // 发布日期
    var source:String!    // 发布来源
    var title:String!   // 发布标题
    var desc:String!     // 文章描述
}


extension BaseModel{
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

    // 使用block





}






















class Baserequest: NSObject {

}
