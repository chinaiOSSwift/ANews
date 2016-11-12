//
//  NetTool.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class NetTool: NSObject,URLSessionDelegate{

    var data = NSMutableData()

    class func requestBaseData(HOME_URL httpUrl:String, httpArg:String,callBack:@escaping (_ array:[AnyObject]?,_ error:NSError?) -> Void) ->Void{

        let session = URLSession.shared
        let urlStr = String.init(format: "%@?%@", arguments: [httpUrl,httpArg]) as NSString

        let url = self.encodeUniCode(urlStr)
        print("url = \(url)")

        var request = URLRequest.init(url:URL.init(string: url as String)!)
        request.timeoutInterval = 4
        request.httpMethod = "GET"
        request.addValue(apikey, forHTTPHeaderField: "apikey")


        let dataTask = session.dataTask(with: request, completionHandler: {(data,response, error) in


            if error == nil{
//               let str =  NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue)
//                print("str = \(str)")
                let obj = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let array = ((obj["showapi_res_body"] as! NSDictionary)["pagebean"] as! NSDictionary)["contentlist"] as? [AnyObject]

                let models:NSMutableArray = NSMutableArray()
                if (array?.count)! > 0{
                    for dic in (array as! [[String:AnyObject]]){
                        models.add(BaseModel.modelWithDic(dic: dic))
                    }
                }
                callBack(models as [AnyObject], nil)

            }else{
                callBack(nil, error as NSError?)
            }

        })
        //启动请求任务
        dataTask.resume()




    }



    class func parasToString(_ para:NSDictionary?)->String
    {
        let paraStr = NSMutableString.init(string: "?")
        for (key,value) in para as! [String :String]
        {
            paraStr.appendFormat("%@=%@&", key,value)
        }
        if paraStr.hasSuffix("&"){
            paraStr.deleteCharacters(in: NSMakeRange(paraStr.length - 1, 1))
        }
        //将URL中的特殊字符进行转吗
        //        paraStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        //移除转码
        //        paraStr.stringByRemovingPercentEncoding
        return String(paraStr)
    }

    class func encodeUniCode(_ string:NSString)->NSString
    {
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)! as NSString
    }




}





























