//
//  WebViewController.swift
//  smallday_test
//
//  Created by zzl on 2016/11/8.
//  Copyright © 2016年 Zhou. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: BaseViewController {

    var urlStr: String?
    var text: String? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ""
        initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI() -> Void {
        self.view.addSubview(self.webView)
        if !(self.urlStr?.isEmpty)! {
            let url = URL.init(string: self.urlStr!)
            let request: URLRequest = URLRequest.init(url: url!)
            self.webView.load(request)
            let text = UILabel.init()
            text.font = UIFont.boldSystemFont(ofSize: 20)
        }
    }
    
    // MARK: - View(页面处理)
    
    
    // MARK: - XXXDelegate
    
    
    // MARK: - 对外接口
    
    
    // MARK: - private methods(内部接口)
    
    
    // MARK: - loading
    
    
    // MARK: - 懒加载
    
    lazy var webView: WKWebView = {
        let temp: WKWebView = WKWebView.init(frame: self.view.bounds)
        temp.backgroundColor = UIColor.white
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
