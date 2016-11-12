//
//  SQLiteTool.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

import CoreData

class SQLiteTool: NSObject {
    static var db:sqlite3_file? = nil
    // 创建数据库

    func createDataBase() -> Void {
        let path = String.init(format: "%@/Documents/data.sqlite", NSHomeDirectory())
//        print("数据库路径:\(path)")
        // 获取文件管理对象
        let fm = FileManager.default
        if !fm.fileExists(atPath: path) { // 不存在数据库文件时, 创建新的文件,如果存在直接打开
            fm.createFile(atPath: path, contents: nil, attributes: nil)
        }
//        sqlite3_open(path.cString(using: String.Encoding.utf8), &SQLiteTool.db)

    }





}























