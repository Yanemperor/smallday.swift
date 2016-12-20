//
//  BaseTableViewController.swift
//  smallday_test
//
//  Created by zzl on 2016/11/3.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit
import MJRefresh

enum RefreshType {
    case normal
    case pullUp     //上拉加载
    case pullDown   //下拉刷新
}

class BaseTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var CellIdentifier = "cell"
    //父类的TableView
    var tableView: UITableView?
    //储存数据的Array
    var dataArray: NSMutableArray?
    //下拉刷新
    lazy var header: MJRefreshNormalHeader = {
        let temp = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(getHeaderData))
        //导航栏下面自动隐藏
        temp?.isAutomaticallyChangeAlpha = true
        //隐藏时间
//        temp?.lastUpdatedTimeLabel.isHidden = true
        return temp!
    }()
    //上拉加载
   lazy var footer: MJRefreshAutoStateFooter = {
        let temp = MJRefreshAutoStateFooter.init(refreshingTarget: self, refreshingAction: #selector(getFooterData))
        return temp!
    }()
    //类型
    var refresh: RefreshType = .normal
    //分页加载时每次加载数据条数, 默认10
    var perPageCount: Int = 10
    //分页加载时第几页
    var startPage: Int = 0
    //数据条数
    var dataCount: Int? {
        didSet {
            if dataCount == 0 {
                self.footer.isHidden = true
            }else{
                self.footer.isHidden = false
            }
            if self.dataCount! < self.perPageCount {
                //没有更多的数据啦
                self.isMore = false
            }else if self.dataCount! == self.perPageCount && self.dataCount! > 0 {
                //还有好多数据
                self.isMore = true
            }
        }
    }
    //是否还有更多数据
    var isMore: Bool = true
    //添加下拉刷新
    func configureRefreshHeader(tableView: UIScrollView) {
        tableView.mj_header = self.header
        self.header.beginRefreshing()
    }
    //添加上拉加载
    func configureRefreshFooter(tableView: UIScrollView) {
        tableView.mj_footer = self.footer
    }
    //添加下拉刷新, 不开启
    func addRefreshHeader(tableView: UIScrollView) {
        tableView.mj_header = self.header
    }
    
    //开始下拉刷新
    func beginDataRefresh() {
        DispatchQueue.main.async {
            self.header.beginRefreshing()
        }
    }
    //结束刷新
    func endDataRefresh() {
        DispatchQueue.main.async {
            self.header.endRefreshing()
            self.footer.endRefreshing()
            if !(self.isMore) {
                self.footer.endRefreshingWithNoMoreData()  //没有更多数据时显示
            }
        }
    }
    
    func getFooterData () {
        self.refresh = .pullUp
        refreshData()
    }
    
    func getHeaderData () {
        self.refresh = .pullDown
        refreshData()
    }
    
    override func refreshData () {
        switch self.refresh {
        case .normal :
            self.startPage = 1
            break
        case .pullDown :
            self.startPage = 1
            break
        case .pullUp :
            self.startPage += 1
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = NSMutableArray.init()
        tableView = UITableView.init(frame: view.bounds)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        view.addSubview(tableView!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
