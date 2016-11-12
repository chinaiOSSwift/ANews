//
//  HomeViewController.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HomeViewController: ViewController {

    var loveArr:[NSDictionary]!
    var preIndex:NSInteger = 1000



    // MARK: - 进行懒加载,加载不同的控件
    lazy var headView:UIView = {
        let frame = CGRect.init(x: 0, y: 64, width: Src_W, height: 31)
        let view:UIView = UIView.init(frame: frame)
        view.backgroundColor = UIColor.red
        view.addSubview(self.titleScrollView)
        let label = UILabel.init(frame: CGRect.init(x: 0, y: btnH, width: Src_W, height: 1))
        label.backgroundColor = UIColor.gray
        view.addSubview(label)
        return view
    }()

    lazy var titleScrollView:UIScrollView = {
        let frame = CGRect.init(x: 0, y: 0, width: Src_W, height: btnH)
        let titleView = UIScrollView.init(frame: frame)
        //        print("count = \(self.loveArr!.count)")
        for i in 0..<self.loveArr!.count{
            let name = (self.loveArr![i]["name"] as! String)
            let normalAttribute = NSMutableAttributedString.init(string:name)
            normalAttribute.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 15),NSForegroundColorAttributeName:UIColor.black], range: NSRange.init(location: 0, length: 2))
            let selectedAttribute =  NSMutableAttributedString.init(string:name)
            selectedAttribute.addAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName:NavColor], range: NSRange.init(location: 0, length: 2))
            let button = UIButton.init(type: UIButtonType.custom)
            button.frame = CGRect.init(x: btnW * CGFloat(i), y: 0, width: btnW, height: btnH)
            button.setTitle(name, for: UIControlState.normal)
            button.setTitle(name, for: UIControlState.highlighted)
            button.setTitleColor(UIColor.black, for: UIControlState.normal)
            button.setTitleColor(UIColor.black, for: UIControlState.highlighted)
            button.setAttributedTitle(normalAttribute, for: UIControlState.normal)
            button.setAttributedTitle(selectedAttribute, for: UIControlState.selected)
            button.backgroundColor = UIColor.clear
            //            button.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
            button.tag = 1000 + i
            if button.tag == 1000{
                button.isSelected = true
            }
            titleView.addSubview(button)
        }
        titleView.tag = 1999
        titleView.bounces = false
        titleView.backgroundColor = UIColor.white
        // 设置横向滚动条隐藏
        titleView.showsHorizontalScrollIndicator = false
        titleView.contentSize = CGSize.init(width: CGFloat(self.loveArr!.count) * btnW, height: 0)
        return titleView
    }()

    //MARK: - 展示内容视图
    lazy var contentView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 95, width: Src_W, height: Src_H - 95), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.isPagingEnabled = true
        // 注册cell
        for dic in self.loveArr{
            let viewClass:String = dic["view"] as! String
            //                print(self.swiftClassFromString(className:viewClass))
            collectionView.register(self.swiftClassFromString(className:viewClass), forCellWithReuseIdentifier:viewClass)
        }
        collectionView.contentOffset = CGPoint.init(x: 0, y: 0)
        collectionView.backgroundColor = UIColor.brown
        collectionView.bounces = true
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.isUserInteractionEnabled = true
        // 加载头视图
        self.makeHeadView()
        self.view.backgroundColor = UIColor.white
        // 重新加载页面
        self.contentView.reloadData()
        //print("unicode = \("北京".lengthOfBytes(using: String.Encoding.unicode))")
    }

    /*
     // MARK: - 标题点击事件
     func buttonClicked(button:UIButton) -> Void {
     // 设置上一个
     let preButton:UIButton = self.titleScrollView.viewWithTag(preIndex) as! UIButton
     preButton.isSelected = false
     // 现在的button
     button.isSelected = true
     let buttonTag:NSInteger = button.tag
     self.preIndex = buttonTag
     // 改变内容显示
     //        self.contentView.setContentOffset(CGPoint.init(x: Src_W * CGFloat(buttonTag), y: 0), animated: false)
     }
     */

    //制作头视图
    func makeHeadView() -> Void {
        self.view.addSubview(self.headView)

    }

    override func viewDidAppear(_ animated: Bool) {
        self.customNAV()
    }

    // MARK: - 自制导航条
    func customNAV() -> Void {
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController!.navigationBar.barTintColor = NavColor
        self.navigationItem.title = "新闻快递"
        // 个人中心
        let button = UIButton.init(type: UIButtonType.system)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        button.setBackgroundImage(UIImage.init(named: "me.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.normal)
        button.setBackgroundImage(UIImage.init(named: "me.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.highlighted)
        button.setBackgroundImage(UIImage.init(named: "me.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: UIControlState.selected)
        button.addTarget(self, action: #selector(self.btnClick(button:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        // 隐藏back(返回)按钮
        self.navigationItem.hidesBackButton = true

    }
    //MARK: - 个人中心点击事件
    func btnClick(button:UIButton) -> Void {
        let me = MeViewController()
        me.navigationItem.title =  "个人中心"
        self.navigationController!.pushViewController(me, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.loveArr!.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dic = self.loveArr[indexPath.item]
        let viewClass:String = dic["view"] as! String
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewClass, for: indexPath) as! BaseCollectionViewCell
        cell.delegate = self
//        cell.tableView.reloadData()
    
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: Src_W, height: Src_H - 95)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.contentView.reloadData()
        let preButton:UIButton = self.titleScrollView.viewWithTag(preIndex) as! UIButton
        preButton.isSelected = false
        let currentIndex = NSInteger(scrollView.contentOffset.x / Src_W)
        let currenButton = self.titleScrollView.viewWithTag(currentIndex + 1000) as! UIButton
        currenButton.isSelected = true
        self.preIndex = currentIndex + 1000

        if scrollView.contentOffset.x >= 6 * Src_W{
            UIView.animate(withDuration: 0.25, animations: { 
                self.titleScrollView.setContentOffset(CGPoint.init(x: CGFloat(currentIndex - 5) * btnW, y: 0), animated: true)
            })
        }else if scrollView.contentOffset.x <= CGFloat(6) * Src_W{
            self.titleScrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }




    }

    func swiftClassFromString(className: String) -> AnyClass! {
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            let cls = NSClassFromString("\(appName).\(className)")
            //            assert(cls != nil, "class not found,please check className")
            return cls
        }
        return nil;
    }

}


extension HomeViewController:ShowDetail{

    func showDetailView(webView: UIViewController) {
        self.navigationController!.pushViewController(webView, animated: true)
    }
}































