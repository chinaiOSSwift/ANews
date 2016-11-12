//
//  FavoViewController.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FavoViewController: UIViewController {

    var dataArr = [BaseModel]()
    var titleName:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.isUserInteractionEnabled = true
        self.makeUI()
        self.makeLeftBar()
        self.isFavo()

    }
    func makeUI() -> Void {
        let tableView:UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0,width: Src_W, height: Src_H - 64), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.register(UINib.init(nibName: "BaseZeroCell", bundle: nil), forCellReuseIdentifier: "BaseZeroCell")
        self.view.addSubview(tableView)

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
        view.addSubview(titleL)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(goBack))
        view.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
    }

    // MARK: - 返回上一层
    func goBack() -> Void {
        self.navigationController!.popViewController(animated: true)
//        print("返回个人中心页面")
    }

    // MARK: - 判断收藏数组为空
    func isFavo() -> Void {
        if self.dataArr.count == 0{
            let netView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Src_W, height: Src_H))
            netView.center = self.view.center
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
            imageView.mj_x = netView.center.x - 25
            imageView.mj_y = netView.center.y - 100
            imageView.image = UIImage.init(named: "no_favo.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            let tipL = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 23))
            tipL.mj_x = imageView.center.x - 150
            tipL.mj_y = imageView.mj_y + imageView.mj_h + 5
            tipL.font = UIFont.systemFont(ofSize: 17)
            tipL.text = "暂无收藏"
            tipL.textAlignment = NSTextAlignment.center
            tipL.textColor = NavColor
            netView.addSubview(tipL)
            netView.addSubview(imageView)
            self.view.addSubview(netView)
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension FavoViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseZeroCell", for: indexPath) as! BaseZeroCell
        let model = self.dataArr[indexPath.row]
        cell.customCellWithMOdel(model: model)
        return cell
    }
    // 返回中文
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    //左滑按钮
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            DataManager.manager.deleteOne(title: dataArr[indexPath.row].title)
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            tableView.reloadData()
            self.isFavo()
        }
    }



    //MARK:- 选中某一行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let web = DetailViewController()
        let model = self.dataArr[indexPath.row]
        web.model = model
        web.sourceName = model.source
        web.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(web, animated: true)
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }




}



















