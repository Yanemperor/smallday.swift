//
//  SmallDayViewController.swift
//  smallday_test
//
//  Created by zzl on 2016/11/3.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit
import YYModel
import SDCycleScrollView
class SmallDayViewController: BaseTableViewController,SDCycleScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        initUI()
    }
    
    func initUI() -> Void {
        self.navigationItem.title = "小日子"
        CellIdentifier = "SmallDayCell"
        self.tableView?.tableHeaderView = self.headView
        self.tableView?.register(UINib.init(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
//        configureRefreshHeader(tableView: self.tableView!)
//        configureRefreshFooter(tableView: self.tableView!)
        
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
        let cell: SmallDayCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! SmallDayCell
        cell.model = self.dataArray?[indexPath.section] as! ListModel?
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model: ListModel = self.dataArray![indexPath.section] as! ListModel
        if (model.shareURL == nil) {
            model.shareURL = ""
        }
        goToWebVC(url: model.shareURL!, text: model.title!)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return 10
    }
    
    // MARK: - 对外接口
    
    
    
    // MARK: - private methods(内部接口)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func getUSDate(dateString: String) -> Void{
        let date: ZhouDateTools = ZhouDateTools.init(en_USTimeStamp: dateString)
        print(date.us_time!)
    }
    
    func buttomButtonAction(button: UIButton) {
        
    }
    
    func goToWebVC(url: String, text: String) {
        let webVC = WebViewController()
        webVC.urlStr = url
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    // MARK: - loading
    func getData() -> Void {
        let dics = getObtainLocalJosnData(fileName: "SmallDayData2")
        let smallDayModel = SmallDayModel.yy_model(withJSON: dics)
        self.smallDayModel = smallDayModel
        for listDic in (smallDayModel?.list)! {
            let list = ListModel.yy_model(withJSON: listDic)
            self.dataArray?.add(list!)
        }
        for headDic in (smallDayModel?.head)! {
            let head = HeadModel.yy_model(withJSON: headDic)
            self.headArray.add(head!)
        }
        self.tableView?.reloadData()
    }
    
    override func refreshData() {
        super.refreshData()
        loadData()
    }
    //网络请求
    var number = 0
    func loadData() {
        //模拟数据在2秒后加载完成
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            //模拟上拉加载, 在第三次时数据全部加载完毕
            if self.number == 2 {
                self.dataCount = 5
                self.number = 0
            }else{
                self.dataCount = 10
                self.number += 1
            }
            self.endDataRefresh()
        }
    }
    
    // MARK: - 懒加载
    var smallDayModel: SmallDayModel?

    
    
    
    lazy var headView: UIView = {
        let tempView = UIView.init(frame: .init(x: 0, y: 0, width: kScreenWidth, height: 300))
        tempView.backgroundColor = UIColor.white
        let tempDate = self.smallDayModel?.day?.date
        let tempMonthArray = tempDate?.components(separatedBy: "-")
        var monthStr: String = tempMonthArray![1]
        let monthInt = Int(monthStr)
        monthStr = self.monthArray[monthInt! - 1] as! String
        
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 60))
        topView.backgroundColor = UIColor.white
        tempView.addSubview(topView)
        
        let day = UILabel.init()
        day.origin = CGPoint.init(x: 10, y: 10)
        day.text = tempMonthArray?[2]
        day.textColor = UIColor.black
        day.textAlignment = .center
        day.font = UIFont.systemFont(ofSize: 22.0)
        day.sizeToFit()
        topView.addSubview(day)
        
        let month = UILabel.init()
        month.origin = CGPoint.init(x: day.width + day.mj_x, y: 18);
        month.text = "\(monthStr)."
        month.textColor = UIColor.black
        month.textAlignment = .center
        month.font = UIFont.systemFont(ofSize: 13.0)
        month.sizeToFit()
        topView.addSubview(month)
        
        let textView = UITextView.init(frame: CGRect.init(x: month.right + 10, y: 5, width: kScreenWidth - month.right - 40, height: topView.height - 10))
        textView.text = self.smallDayModel?.day?.title
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textView.isUserInteractionEnabled = false
        topView.addSubview(textView)
        
        let cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 60, width: kScreenWidth, height: 150), delegate: self, placeholderImage: nil)
        cycleScrollView?.autoScroll = true
        var tempArray = NSMutableArray.init()
        for model in self.headArray {
            let tempModel: HeadModel = model as! HeadModel
            let img: String = tempModel.img!
            tempArray.add(img)
        }
        cycleScrollView?.imageURLStringsGroup = tempArray as [AnyObject]
        tempView.addSubview(cycleScrollView!)
        
        let buttomView = UIView.init(frame: CGRect.init(x: 0, y: (cycleScrollView?.bottom)!, width: kScreenWidth, height: tempView.height - 210))
        buttomView.backgroundColor = RGB(r: 240, g: 240, b: 240)
        let width = (kScreenWidth - 4 * 10) / 3.0
        let title = ["好物","美文","娱乐"]
        let image = ["wshop","wread","wlook"]
        for i in 0..<3 {
            let button = UIButton.init(frame: CGRect.init(x: CGFloat(i) * (width + 10) + 10, y: 10, width: width, height: buttomView.height - 20))
            button.backgroundColor = UIColor.white
            button.tag = 100 + i
            button.setTitle(title[i], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setImage(UIImage.init(named: image[i]), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            button.titleEdgeInsets = UIEdgeInsetsMake(-10, -65, 0, 0)
            button.addTarget(self, action: #selector(buttomButtonAction(button:)), for: .touchUpInside)
            buttomView.addSubview(button)
        }
        tempView.addSubview(buttomView)
        return tempView
    }()
    
    lazy var headArray: NSMutableArray = {
        let temp = NSMutableArray.init()
        return temp
    }()
    
    lazy var monthArray: NSMutableArray = {
        let array = ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"]
        let temp = NSMutableArray.init(array: array)
        return temp;
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
