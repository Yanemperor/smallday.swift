//
//  SmallDayCell.swift
//  smallday_test
//
//  Created by zzl on 2016/11/7.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit
import SDWebImage
class SmallDayCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeFrom: UILabel!
    var model: ListModel? {
        didSet{
            self.img.sd_setImage(with: model?.img, placeholderImage: nil)
            self.title.text = model?.title
            if (model?.name != nil) && (model?.space?.name != nil) {
                self.timeFrom.text = model?.name
            }else{
                self.timeFrom.text = ""
            }
        }
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
