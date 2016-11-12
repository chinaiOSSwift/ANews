//
//  FirstViewController.swift
//  BJNEWS
//
//  Created by qianfeng on 16/11/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // 首先从本地读取数据, 判断时候是第一次登陆, 如果是第一次登陆让用户选择感兴趣标签  如果不是第一次登陆直接展示用户上次选择的标签
    }

    // 从本地读取数据
    func readDataFromLocal() -> Void {
        let path = String.init(format: "%@/Documents/%@.array", NSHomeDirectory(),"love")
        let array = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? NSArray
        if array != nil{
            let home = HomeViewController()
            home.loveArr = array as! [NSDictionary]
            self.navigationController?.pushViewController(home, animated: true)
        }else{
             self.navigationController?.pushViewController(InterestionViewController(), animated: true)
        }
    }






    // 页面即将显示
    override func viewWillAppear(_ animated: Bool) {
        // 设置隐藏导航栏
        self.navigationController!.isNavigationBarHidden = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - 微博登录
    @IBAction func weiBoLogin(_ sender: UIButton) {
        print("微博登录")

    }

    //MARK: - 微信登录
    @IBAction func weiXinLogin(_ sender: UIButton) {
        print("微信登录")
    }

    // MARK: - 没有登录
    @IBAction func noLogin(_ sender: UIButton) {
      self.readDataFromLocal()
    }


}
