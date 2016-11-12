//
//  DetailViewController.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var model:BaseModel!
    var sourceName:String!
    var flag:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeUI()
        self.makeLeftBar()

    }


    func makeUI() -> Void {
        let button = UIButton.init(type: UIButtonType.system)
        let frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        button.frame = frame
        button.setImage(UIImage.init(named: "icon_star@2x.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)

        if DataManager.manager.findOne(title: self.model.title){
            button.setImage(UIImage.init(named: "icon_star_full@2x.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
            flag = true
        }

    }


    func buttonClick(sender:UIButton) -> Void {
        if !flag{
            DataManager.manager.insert(model: model)
            print("收藏成功")
            // 弹出收藏成功界面
            sender.setImage(UIImage.init(named: "icon_star_full@2x.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        }else{
            print("移除收藏")
            DataManager.manager.deleteOne(title: model.title)
            sender.setImage(UIImage.init(named: "icon_star@2x.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        }
    }

    func makeLeftBar() -> Void {
        self.navigationController!.navigationBar.barTintColor = UIColor.white
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 30))
        view.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = true
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 2, width: 22, height: 22))
        imageView.image = UIImage.init(named: "goBack.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        view.addSubview(imageView)
        let titleL = UILabel.init(frame: CGRect.init(x: imageView.mj_x + imageView.mj_w + 3, y: -2, width: 150, height: 30))
        titleL.text = self.sourceName
        titleL.textColor = UIColor.black
        titleL.adjustsFontSizeToFitWidth = true
        titleL.font = UIFont.systemFont(ofSize: 17)
        titleL.textAlignment = NSTextAlignment.left
        view.addSubview(titleL)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(goBack))
        view.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
    }

    func goBack() -> Void {
        self.navigationController!.popViewController(animated: true)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let frame = CGRect.init(x: 0, y: 0, width: Src_W, height: Src_H)
        let web = UIWebView.init(frame: frame)
        web.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        web.loadRequest(URLRequest.init(url: URL.init(string: model!.link)!))
        self.view.addSubview(web)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}



















