//
//  BaseTabBarController.swift
//  smallday_test
//
//  Created by zzl on 2016/11/3.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createSubController()
        createTabBar()
        // Do any additional setup after loading the view.
    }

    func createSubController() -> Void {
        let array = ["SmallDay","Fun","Find","My"]
        var navArray = [UINavigationController]()
        for i in 0..<array.count {
            let storyBoard = UIStoryboard.init(name: array[i], bundle: nil)
            let nav: UINavigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
            navArray.append(nav)
        }
        self.viewControllers = navArray
    }
    
    func createTabBar() -> Void {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 49))
        view.backgroundColor = UIColor.white
        self.tabBar.addSubview(view)
        let na = ["life_1","fun_1","fstore_1","my_1"]
        let sele = ["life_2","fun_2","fstore_2","my_2"]
        let array = ["小日子","好玩","找店","我的"]
        UITabBar.appearance().tintColor = UIColor.black
        for i in 0..<array.count {
            let barItem = self.tabBar.items?[i]
            barItem?.image = UIImage.init(named: na[i])
            barItem?.selectedImage = UIImage.init(named: sele[i])
            barItem?.title = array[i]
        }
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
