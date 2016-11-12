//
//  ConfirgFile.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 屏幕的宽高
let Src_W:CGFloat = UIScreen.main.bounds.width
let Src_H:CGFloat = UIScreen.main.bounds.height

let apikey = "f305aabb6345c0bd6d7712143c1bbf5f"
let HOME_URL = "http://apis.baidu.com/showapi_open_bus/channel_news/search_news"
let NavColor:UIColor = UIColor.init(red: 65 / 255.0, green: 108 / 255.0, blue: 233 / 255.0, alpha: 1.0)


// 滚动条的高度
let SrcollView_H:CGFloat = 200

var btnW:CGFloat = UIScreen.main.bounds.width / 6// 按钮的宽度
var space:CGFloat = 10// 距离屏幕左端的距离
var topSpace:CGFloat = 0 // 距离最顶端的距离
var btnH:CGFloat = 30// 按钮的高度
// 展示内容的高度  去掉 Nan - btnH
let Content_H = UIScreen.main.bounds.height - 64 - btnH
// 其他页面的展示内容
let ContentView_H = UIScreen.main.bounds.height - 64
