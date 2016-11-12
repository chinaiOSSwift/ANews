//
//  BaseCollectionViewCell.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

protocol ShowDetail:NSObjectProtocol {
    // 跳转到制定的webView
    func showDetailView(webView:UIViewController) -> Void
}


class BaseCollectionViewCell: UICollectionViewCell {
    // 代理指针
    weak var delegate:ShowDetail?
    // 数据源
    var dataArr = NSMutableArray()
    var data = NSMutableData()
    var page:NSInteger = 1
    var flag:Bool = false
    var channelID:String?
    lazy var tableView:UITableView = {
        let frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let tableView = UITableView.init(frame: frame)
        tableView.backgroundColor = UIColor.brown
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.register(UINib.init(nibName: "BaseZeroCell", bundle: nil
        ), forCellReuseIdentifier: "BaseZeroCell")
        tableView.register(UINib.init(nibName: "BaseOneCell", bundle: nil
        ), forCellReuseIdentifier: "BaseOneCell")
        tableView.register(UINib.init(nibName: "BaseTwoCell", bundle: nil
        ), forCellReuseIdentifier: "BaseTwoCell")
        tableView.register(UINib.init(nibName: "BaseThreeCell", bundle: nil
        ), forCellReuseIdentifier: "BaseThreeCell")
        tableView.backgroundColor = UIColor.cyan
        tableView.header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.page = 1
            self.flag = true
            self.loadData()

        })
        tableView.footer = MJRefreshAutoFooter.init(refreshingBlock: {
            self.page += 1
            self.flag = false
            self.loadData()
        })
        self.contentView.addSubview(tableView)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.darkGray
        //        if let array = self.readDataFromLocal(){  // 读取缓存
        //            self.dataArr = NSMutableArray.init(array: array)
        self.tableView.reloadData()
        //        }else{
        //            self.loadData()
        //        }
    }
    //网络加载com.newsfirst.bj
    func loadData() -> Void {
        let preArg = "channelId=\(self.channelID!)&page="
        let behArg = "&needContent=0&needHtml=0"
        let httpArg = String.init(format: "%@%d%@", preArg,self.page,behArg)
        print("httpArg = \(httpArg)")
        HDManager.startLoading()
        NetTool.requestBaseData(HOME_URL: HOME_URL, httpArg: httpArg, callBack: { (array, error) in
            if error == nil{
                //                if self.flag == true{
                //                    self.dataArr.removeAllObjects()
                //                    self.writeDataToLocal(array: array! as NSArray)
                //                }
                self.dataArr.addObjects(from: array!)
                self.tableView.reloadData()
                //                if !self.flag{
                //                    self.writeDataToLocal(array: array! as NSArray)
                //                }

            }else{
                print("error = \(error)")
            }

            self.tableView.header.endRefreshing()
            self.tableView.footer.endRefreshing()
        })
        HDManager.stopLoading()
    }






    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    // 往本地存储数据
    func writeDataToLocal(array:NSArray) -> Void {
        let name = NSStringFromClass(type(of: self))
        // 拼接完整路径
        let path = String.init(format: "%@/Documents/%@.txt", NSHomeDirectory(),name)
        let flag = NSKeyedArchiver.archiveRootObject(array, toFile: path)
        if flag{
            print("\(path)归档成功")
        }
    }
    // 读取数据
    func readDataFromLocal() -> NSArray? {
        let name = NSStringFromClass(type(of:self))
        let path = String.init(format: "%@/Documents/%@.txt", NSHomeDirectory(),name)
        let array = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? NSArray
        return array
    }

}


extension BaseCollectionViewCell:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count = \(self.dataArr.count)")
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataArr[indexPath.row] as! BaseModel
        var cellID = "BaseZeroCell"
        if model.imageurls?.count == 1{ // 一张图片
            cellID = "BaseOneCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BaseOneCell
            cell.customCellWithMOdel(model: model)
            return cell
        }else if model.imageurls?.count == 2{  //两张图片
            cellID = "BaseTwoCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BaseTwoCell
            cell.customCellWithMOdel(model: model)
            return cell
        }else if model.imageurls?.count == 3{ // 三张图片
            cellID = "BaseThreeCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BaseThreeCell
            cell.customCellWithMOdel(model: model)
            return cell
        }else{ // 没有图片
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BaseZeroCell
            cell.customCellWithMOdel(model: model)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataArr[indexPath.row] as! BaseModel
        let web = DetailViewController()
        web.sourceName = model.source
        web.model = model
        // 这里需要传 来源
        self.delegate?.showDetailView(webView: web)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model:BaseModel = self.dataArr[indexPath.row] as! BaseModel
        if model.imageurls?.count == 3 || model.imageurls?.count == 2{
            return 130
        }
        return 90
    }
}



























