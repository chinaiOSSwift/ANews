//
//  BaseOneCell.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseOneCell: UITableViewCell {


    @IBOutlet weak var titleL: UILabel!

    @IBOutlet weak var iconView: UIImageView!

    @IBOutlet weak var sourceL: UILabel!

    @IBOutlet weak var dateL: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func customCellWithMOdel(model:BaseModel) -> Void {
        let imageUrl = (model.imageurls!.first)!["url"] as! String
        iconView.sd_setImage(with: NSURL.init(string: imageUrl) as URL!)
        titleL.text = model.title
        sourceL.text = model.source
        dateL.text = model.pubDate
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



















