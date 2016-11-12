//
//  InterestionViewController.swift
//  BJNEWS
//
//  Created by qianfeng on 16/11/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class InterestionViewController: UIViewController {

    // 用户兴趣标签数组
    lazy var loveArr:NSMutableArray = {
        let array = NSMutableArray()
        return array
    }()

    /*
     // 注册cell
     collectionView.register(HeadlinesCell.self, forCellWithReuseIdentifier: "HeadlinesCell")
     collectionView.register(InternationalCell.self, forCellWithReuseIdentifier: "InternationalCell")
     collectionView.register(EntertainmentCell.self, forCellWithReuseIdentifier: "EntertainmentCell")
     collectionView.register(TechnologyCell.self, forCellWithReuseIdentifier: "TechnologyCell")
     collectionView.register(WomanCell.self, forCellWithReuseIdentifier: "WomanCell")
     collectionView.register(EducationCell.self, forCellWithReuseIdentifier: "EducationCell")
     collectionView.register(CbaCell.self, forCellWithReuseIdentifier: "CbaCell")
     collectionView.register(SocialCell.self, forCellWithReuseIdentifier: "SocialCell")
     collectionView.register(InternetCell.self, forCellWithReuseIdentifier: "InternetCell")
     collectionView.register(SportCell.self, forCellWithReuseIdentifier: "SportCell")
     collectionView.register(DomesticCell.self, forCellWithReuseIdentifier: "DomesticCell")
     collectionView.register(FinanceCell.self, forCellWithReuseIdentifier: "FinanceCell")
     collectionView.register(MilitaryCell.self, forCellWithReuseIdentifier: "MilitaryCell")
     collectionView.register(HouseCell.self, forCellWithReuseIdentifier: "HouseCell")
     collectionView.register(CarCell.self, forCellWithReuseIdentifier: "CarCell")
     collectionView.register(HealthCell.self, forCellWithReuseIdentifier: "HealthCell")
     collectionView.register(SexCell.self, forCellWithReuseIdentifier: "SexCell")
     collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
     collectionView.register(TVseriesCell.self, forCellWithReuseIdentifier: "TVseriesCell")
     collectionView.register(GameCell.self, forCellWithReuseIdentifier: "GameCell")
     */

    lazy var dataSource:[NSDictionary] = {
        let data = [["name":"头条","image":"头条.png","view":"HeadlinesCell"],["name":"国际","image":"国际.png","view":"InternationalCell"],["name":"娱乐","image":"娱乐.png","view":"EntertainmentCell"],["name":"科技","image":"科技.png","view":"TechnologyCell"],["name":"女人","image":"女人.png","view":"WomanCell"],["name":"教育","image":"教育","view":"EducationCell"],["name":"CBA","image":"篮球","view":"CbaCell"],["name":"社会","image":"社会","view":"SocialCell"],["name":"互联网","image":"互联网","view":"InternetCell"],["name":"体育","image":"体育","view":"SportCell"],["name":"国内","image":"国内","view":"DomesticCell"],["name":"财经","image":"财经","view":"FinanceCell"],["name":"军事","image":"军事","view":"MilitaryCell"],["name":"房产","image":"房产","view":"HouseCell"],["name":"汽车","image":"汽车","view":"CarCell"],["name":"健康","image":"健康","view":"HealthCell"],["name":"两性","image":"两性","view":"SexCell"],["name":"影视","image":"影视.png","view":"MovieCell"],["name":"电视剧","image":"电视剧.png","view":"TVseriesCell"],["name":"游戏","image":"游戏.png","view":"GameCell"]]
        return data as [NSDictionary]
    }()


    lazy var contentCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height - 64)
        let contentView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        contentView.showsHorizontalScrollIndicator = false
        contentView.showsVerticalScrollIndicator = true
        contentView.backgroundColor = UIColor.green
        // 注册cell

        contentView.register(UINib.init(nibName: "InterestionCell", bundle: nil
        ), forCellWithReuseIdentifier: "InterestionCell")
        contentView.delegate = self
        contentView.dataSource = self

        self.view.addSubview(contentView)
        return contentView

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        self.view.backgroundColor = UIColor.red
        self.contentCollectionView.reloadData()

        self.readDataFromLocal() // 从本地读取数据


    }

    // 页面即将显示
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.customNAV()
    }

    //MARK: - 自定制navigation 
    func customNAV() -> Void {
        self.navigationItem.title = "选择您的兴趣标签"
        self.navigationController!.navigationBar.barTintColor = UIColor.white

        // 后退
        let leftImage = UIImage.init(named: "back.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: leftImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.backButton))
        // 前进
        let rightImage = UIImage.init(named: "go.png")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: rightImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.goButton))
    }

    //MARK: - 后退一步
    func backButton() -> Void {
        self.navigationController!.popViewController(animated: true)
    }

    //MARK: - 前进一步
    func goButton() -> Void {
        for dic in self.loveArr{
            print("标签名字:\((dic as! NSDictionary)["name"])")
        }
        self.writeDataToLocal(self.loveArr)
        // 传值跳转页面
        let home = HomeViewController()
        home.loveArr = NSArray.init(array: self.loveArr) as! [NSDictionary]
        self.navigationController!.pushViewController(home, animated: true)
    }

    // 将数组写进沙河路径
    func writeDataToLocal(_ array:NSArray) -> Void{
        // 拼接完整的沙盒路径
        let path = String.init(format: "%@/Documents/%@.array", NSHomeDirectory(),"love")
        print("归档路径:\(path)")
        let flag = NSKeyedArchiver.archiveRootObject(array, toFile: path)
        if flag{
            print("归档成功")
        }
    }

    // 从本地读取数据
    func readDataFromLocal() -> Void {
        let path = String.init(format: "%@/Documents/%@.array", NSHomeDirectory(),"love")
        let array = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? NSArray
        if array != nil{
            self.loveArr = array as! NSMutableArray
            for dic in array!{
                print("标签名字:\((dic as! NSDictionary)["name"])")
            }
        }else{
            print("页面第一次进入")
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

extension InterestionViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestionCell", for: indexPath) as! InterestionCell
        cell.iconName.text = (self.dataSource[indexPath.item])["name"] as? String
        cell.iconView.backgroundColor = UIColor.white
        let imageName = (self.dataSource[indexPath.item])["image"] as! String
        cell.iconView.image = UIImage.init(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //MARK - 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! InterestionCell
        if cell.iconBtn.isSelected{
            cell.iconBtn.isSelected = false
            cell.iconBtn.setBackgroundImage(UIImage.init(named: "不选中.png"), for: .normal)
            print("不选了")
            collectionView.deselectItem(at: indexPath, animated: true) // 反选

            self.loveArr.remove(self.dataSource[indexPath.item]) //移除选中的标签

        }else{
            cell.iconBtn.isSelected = true
            cell.iconBtn.setBackgroundImage(UIImage.init(named: "选中.png"), for: .selected)
            self.loveArr.add(self.dataSource[indexPath.item]) //添加选中的标签
            print("选中了")
        }
    }

    //MARK - 即将要显示
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        for dic in self.loveArr{
            if ((dic as! NSDictionary)["name"] as? String) == ((self.dataSource[indexPath.item] )["name"] as? String){
//                print("已经选中了")
                (cell as! InterestionCell).iconBtn.isSelected = true
                (cell as! InterestionCell).iconBtn.setBackgroundImage(UIImage.init(named: "选中.png"), for: .selected)

            }

        }


    }





    //    //MARK - 反选了
    //    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    //        let cell = collectionView.cellForItem(at: indexPath) as! InterestionCell
    //        cell.iconName.text = "不选了"
    //        cell.iconBtn.isSelected = false
    //        print("反选了")
    //    }
    
    
    
}



















