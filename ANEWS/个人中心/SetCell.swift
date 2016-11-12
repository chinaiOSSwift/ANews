//
//  SetCell.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/12.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SetCell: UITableViewCell {


    @IBOutlet weak var iconView: UIImageView!

    @IBOutlet weak var nameL: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
