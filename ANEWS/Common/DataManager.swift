//
//  DataManager.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    // 只构建一次,相当于单例
    static let manager = DataManager()
    let fmdb:FMDatabase

    override init(){
        // 需要管理的数据库路径
        let path = NSHomeDirectory() + "/Documents/favo.db"
        // 数据库路径和FMDB 建立关系
        fmdb = FMDatabase.init(path: path)
        // 打开数据库, 如果文件存在就打开, 不存在先创建在打开
        if !fmdb.open(){
            print(fmdb.lastErrorMessage())
            return
        }
        let createSql = "create table if not exists favo(numID integer primary key autoincrement, link varchar(255), pubDate varchar(255), source varchar(255), title varchar(255))"
        do {
            // 执行sql 语句
            try fmdb.executeUpdate(createSql, values: nil)
        } catch  {
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }
    //MARK: - 插入一条数据
    func insert(model:BaseModel) -> Void {
        let insertSql = "insert into favo(link,pubDate,source,title) values(?,?,?,?)"
        fmdb.open()
        do {
            try fmdb.executeUpdate(insertSql, values: [model.link,model.pubDate,model.source,model.title])
        } catch  {
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }
    // 查询说有的数据
    func findAll() -> [BaseModel] {
        fmdb.open()
        var tempArr = [BaseModel]()
        let findAllSql = "select * from favo"
        do {
            let rs = try fmdb.executeQuery(findAllSql, values: nil)
            while rs.next() {
                let model = BaseModel()
                model.link = rs.string(forColumn: "link")
                model.pubDate = rs.string(forColumn: "pubDate")
                model.source = rs.string(forColumn: "source")
                model.title = rs.string(forColumn: "title")
                tempArr.append(model)
            }

        } catch  {
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
        return tempArr
    }

    // MARK: - 删除一条数据
    func deleteOne(title:String) -> Void {
        fmdb.open()
        let deleteSql = "delete from favo where title = ?"
        do {
            try fmdb.executeUpdate(deleteSql, values: [title])
        } catch  {
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }
    //MARK: - 查找一条数据
    func findOne(title:String) -> Bool {
        fmdb.open()
        var flag = false
        let findOneSql = "select * from favo where title = ?"
        do {
           let rs = try fmdb.executeQuery(findOneSql, values: [title])
            while rs.next() {
                flag = true
            }
        } catch  {
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
        return flag
    }

    // MARK: - 删除所有
    func deleteAll() -> Void {
        fmdb.open()
        let deleteAll = "drop table favo"
        do {
            try fmdb.executeUpdate(deleteAll, values: nil)
        } catch  {
            print(fmdb.lastErrorMessage())
        }
        fmdb.close()
    }

}











