//
//  CbaCell.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CbaCell: BaseCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.channelID = "5572a10ab3cdc86cf39001e9"
        self.contentView.backgroundColor = UIColor.white
        super.loadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}