//
//  MeViewController.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    var titleName:String!
    let titleArr:[String] = ["我的收藏","清除收藏"]
    let imageArray:[String] = ["favo.png","set.png"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.isUserInteractionEnabled = true
        self.automaticallyAdjustsScrollViewInsets = false
        self.makeUI()
        self.makeLeftBar()

    }

    //MARK: - 制作左按钮
    func makeLeftBar() -> Void {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 130, height: 30))
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = true
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 2, width: 22, height: 22))
        imageView.image = UIImage.init(named: "goBack.png")!.withRenderingMode(.alwaysOriginal)
        view.addSubview(imageView)
        let titleL = UILabel.init(frame: CGRect.init(x: imageView.mj_x + imageView.mj_w, y: -2, width: 150, height: 30))
        titleL.text = self.titleName
        titleL.textColor = UIColor.black
        titleL.adjustsFontSizeToFitWidth = true
        titleL.font = UIFont.systemFont(ofSize: 17)
        titleL.textAlignment = NSTextAlignment.left
        titleL.isUserInteractionEnabled = true
        view.addSubview(titleL)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.goBack))
        view.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
    }

    // MARK: - 返回上一层
    func goBack() -> Void {
        self.navigationController!.popViewController(animated: true)
//        print("返回上一层")
    }

    func makeUI() -> Void {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: Src_W, height: Src_H - 64))
        tableView.backgroundColor = UIColor.clear
        tableView.register(UINib.init(nibName: "SetCell", bundle: nil), forCellReuseIdentifier: "SetCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorColor = UIColor.clear
        self.view.addSubview(tableView)
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension MeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetCell", for: indexPath) as! SetCell
        cell.nameL.text = self.titleArr[indexPath.row]
        cell.iconView.image = UIImage.init(named: imageArray[indexPath.row])!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let favoView = FavoViewController()
            favoView.dataArr = DataManager.manager.findAll()
            favoView.titleName = "我的收藏"
            favoView.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(favoView, animated: true)

        }else if indexPath.row == 1{
            let ac = UIAlertController.init(title: "⚠️", message: "清空收藏", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (action) in
                // 在这里清除数据
                var needDeleteArr = DataManager.manager.findAll()
                for each in needDeleteArr{
                    DataManager.manager.deleteOne(title: each.title)
                }
                needDeleteArr.removeAll()
            })
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.default, handler: { (action) in

            })
            ac.addAction(cancelAction)
            ac.addAction(okAction)
            self.present(ac, animated: true, completion: nil)
        }
    }

}



















