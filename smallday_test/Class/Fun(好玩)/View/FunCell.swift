//
//  FunCell.swift
//  smallday_test
//
//  Created by zzl on 2016/11/29.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit

class FunCell: UITableViewCell {
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var timeText: UILabel!
    
    var model: FunListModel? {
        didSet{
            backImage.sd_setImage(with: URL.init(string: model?.imgs![0] as! String), placeholderImage: nil)
            title.text = model?.title
            let array: NSArray = model?.date!["time_list"] as! NSArray
            let timeList: TimeListModel = TimeListModel.yy_model(withJSON: array[0])!
            let tempStr: String = timeList.start_time!
            var timeArray = tempStr.components(separatedBy: ":")
            let time: String = "\(timeArray[0]):\(timeArray[1])"
            if timeList.weekdays?.characters.count == 0 {
                timeArray = (timeList.end_date?.components(separatedBy: "-"))!
                let endTime = "\(timeArray[1]):\(timeArray[2])"
                timeText.text = "截止至\(endTime) | \(model?.tag)"
                timeText.text = String.init(format: "%@ | %@", endTime,(model?.tag)!)
            }else if timeList.weekdays?.characters.count == 1 {
                timeText.text = String.init(format: "每周%@ \(time) | %@", getWeek(str: timeList.weekdays!),(model?.tag)!)
            }
        }
    }
    
    func getWeek(str: String) -> String {
        let number: Int = Int(str)!
        switch number {
        case 0:
            return "一"
        case 1:
            return "二"
        case 2:
            return "三"
        case 3:
            return "四"
        case 4:
            return "五"
        case 5:
            return "六"
        case 6:
            return "日"
        default:
            return ""
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
