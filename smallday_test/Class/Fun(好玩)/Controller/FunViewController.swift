//
//  FunViewController.swift
//  smallday_test
//
//  Created by zzl on 2016/11/3.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit
import SDCycleScrollView

class FunViewController: BaseTableViewController, SDCycleScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "好玩"
        loadData()
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI() -> Void {
        CellIdentifier = "FunCell"
        self.tableView?.tableHeaderView = self.headView
        self.tableView?.register(UINib.init(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
    }
    
    // MARK: - View(页面处理)
    
    
    // MARK: - XXXDelegate
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataArray?.count)!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FunCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! FunCell
        cell.model = self.dataArray?[indexPath.section] as? FunListModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model: FunListModel = self.dataArray![indexPath.section] as! FunListModel
        goToWebVC(url: model.url!, text: model.title!)
    }

    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let model: HeadModel = (self.headArray[index] as? HeadModel)!
        goToWebVC(url: "\(model.url!)", text: model.title!)
    }
    
    // MARK: - 对外接口
    
    
    // MARK: - private methods(内部接口)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func goToWebVC(url: String, text: String) {
        let webVC = WebViewController()
        webVC.urlStr = url
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    // MARK: - loading
    func loadData() {
        let dics = getObtainLocalJosnData(fileName: "FunData")
        let smallDayModel: SmallDayModel = SmallDayModel.yy_model(withJSON: dics)!
        print(smallDayModel)
        for dic in smallDayModel.head! {
            let headModel: HeadModel = HeadModel.yy_model(withJSON: dic)!
            self.headArray.add(headModel)
        }
        for dic in smallDayModel.list! {
            let listModel: FunListModel = FunListModel.yy_model(withJSON: dic)!
            self.dataArray?.add(listModel)
        }
    }
    
    
    
    // MARK: - 懒加载
    
    lazy var headView: UIView = {
        let temp = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 160))
        temp.backgroundColor = UIColor.white
        
        let cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 150), delegate: self, placeholderImage: nil)
        cycleScrollView?.backgroundColor = UIColor.white
        cycleScrollView?.autoScroll = true
        cycleScrollView?.autoScrollTimeInterval = 4.0
        temp.addSubview(cycleScrollView!)
        var url = NSMutableArray.init()
        for model in self.headArray {
            let headModel: HeadModel = model as! HeadModel
            let img: String = headModel.img!
            url.add(img)
        }
        cycleScrollView?.imageURLStringsGroup = url as [AnyObject]
        return temp
    }()
    
    lazy var headArray: NSMutableArray = {
        let temp = NSMutableArray.init()
        return temp
    }()
    

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
