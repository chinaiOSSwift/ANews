//
//  BaseTwoCell.swift
//  ANEWS
//
//  Created by qianfeng on 16/11/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BaseTwoCell: UITableViewCell {



    @IBOutlet weak var iconViewOne: UIImageView!


    @IBOutlet weak var iconViewTwo: UIImageView!


    @IBOutlet weak var titleL: UILabel!


    @IBOutlet weak var sourceL: UILabel!

    @IBOutlet weak var dateL: UILabel!


    func customCellWithMOdel(model:BaseModel) -> Void {
        let imageUrl = (model.imageurls!.first)!["url"] as! String
        let imageUrl2 = (model.imageurls![1] as NSDictionary)["url"] as! String
        iconViewOne.sd_setImage(with: URL.init(string: imageUrl))
        iconViewTwo.sd_setImage(with: URL.init(string: imageUrl2))
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














