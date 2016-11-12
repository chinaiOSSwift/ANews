//
//  BaseZeroCell.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseZeroCell: UITableViewCell {


    @IBOutlet weak var titleL: UILabel!

    @IBOutlet weak var sourceL: UILabel!

    @IBOutlet weak var dateL: UILabel!

    func customCellWithMOdel(model:BaseModel) -> Void {
        titleL.text = model.title
        sourceL.text = model.source
        dateL.text = model.pubDate
    }




    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
