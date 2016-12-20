//
//  BaseViewController.swift
//  smallday_test
//
//  Created by zzl on 2016/11/3.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit
import SwiftyJSON
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBtn()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    func setBackBtn() {
        let backNormal = UIImage.init(named: "back_1")!
        let backSelected = UIImage.init(named: "back_2")!
        let button = UIButton.init()
        button.size = backNormal.size
        button.setImage(backNormal, for: .normal)
        button.setImage(backSelected, for: .selected)
        button.addTarget(self, action: #selector(buttonAction) , for: .touchUpInside)
        let backItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = backItem
    }

    func buttonAction () {
        self.navigationController!.popViewController(animated: false)
    }
    
    func getObtainLocalJosnData(fileName: String) -> NSDictionary {
        let filePath = Bundle.main.path(forResource: fileName, ofType: nil)
        let data = NSData.init(contentsOfFile: filePath!)
        let json = JSON(data: data as! Data)
        if let dic = json.dictionaryObject {
            return dic as NSDictionary
        }
        return [:]
    }
    //父类方法
    func refreshData() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
