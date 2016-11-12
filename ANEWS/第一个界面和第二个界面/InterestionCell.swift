//
//  InterestionCell.swift
//  BJNEWS
//
//  Created by qianfeng on 16/11/9.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class InterestionCell: UICollectionViewCell {


    @IBOutlet weak var iconView: UIImageView!


    @IBOutlet weak var iconBtn: UIButton!

    @IBOutlet weak var iconName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.iconBtn.layer.masksToBounds = true
        self.iconBtn.layer.cornerRadius = self.iconBtn.frame.height / 2
//        self.iconView.backgroundColor = UIColor.purple
    }

}
