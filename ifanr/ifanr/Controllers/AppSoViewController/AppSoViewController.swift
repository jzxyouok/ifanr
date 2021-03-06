//
//  AppSoViewController.swift
//  ifanr
//
//  Created by sys on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

//class AppSoViewController: BasePageController {
class AppSoViewController: UIViewController, ScrollViewControllerReusable {

    var dataSource : Array<AppSoModel> = Array()
    override func viewDidLoad() {
        
//        self.localDataSource = ["appso_header_background", "tag_appsolution", "AppSolution", "智能手机更好用的秘密"]
        
        super.viewDidLoad()
        
        setupTableView()
        setupPullToRefreshView()
        
        self.getData()
//        self.tableView.separatorStyle = .None
    }
    
    
    func getData() {
        Alamofire.request(.GET, "https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=2&post_type=app&posts_per_page=12&sign=52eb3928dc47f57a26b00932226eff22&timestamp=1467295827", parameters: [:])
            .responseJSON { response in
                
                if let dataAny = response.result.value {
                    
                    let dataDic : NSDictionary = (dataAny as? NSDictionary)!
                    if dataDic["data"] is NSArray {
                        let dataArr : NSArray = (dataDic["data"] as? NSArray)!
                        for item in dataArr {
                            self.dataSource.append(AppSoModel(dict: item as! NSDictionary))
                        }
                    }
                    self.tableView.reloadData()
                }
        }
    }
    //MARK: --------------------------- Getter and Setter --------------------------
    var tableView: UITableView!
    /// 下拉刷新
    var pullToRefresh: PullToRefreshView!
    /// 下拉刷新代理
    var scrollViewReusable: ScrollViewControllerReusableDataSource!
    var tableHeaderView: UIView! = {
        return TableHeaderView(model: TableHeaderModelArray[2])
    }()
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dataSource.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        var cell: UITableViewCell? = nil
//        let curModel = self.dataSource[indexPath.row];
//        
//        debugPrint(curModel.app_icon_url)
//        
//        if curModel.app_icon_url != "" {
//            cell    = AppSoTableViewCell.cellWithTableView(tableView)
//            (cell as! AppSoTableViewCell).model = curModel
//        } else {
//            cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
//            (cell as! PlayingZhiTableViewCell).appSoModel = curModel
//        }
//        
//        return cell!
//    }
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return AppSoTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 20
//    }
}

// MARK: - 下拉刷新回调
extension AppSoViewController {
    func pullToRefreshViewWillRefresh(pullToRefreshView: PullToRefreshView) {
        print("将要下拉")
    }
    
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView) -> Task {
        return ({
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                NSThread.sleepForTimeInterval(2.0)
                dispatch_async(dispatch_get_main_queue(), {
                    pulllToRefreshView.endRefresh()
                })
            })
        })
    }
}


// MARK: - tableView代理和数据源
extension AppSoViewController {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        let curModel = self.dataSource[indexPath.row];
        
        debugPrint(curModel.app_icon_url)
        
        if curModel.app_icon_url != "" {
            cell    = AppSoTableViewCell.cellWithTableView(tableView)
            (cell as! AppSoTableViewCell).model = curModel
        } else {
            cell    = PlayingZhiTableViewCell.cellWithTableView(tableView)
            (cell as! PlayingZhiTableViewCell).appSoModel = curModel
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AppSoTableViewCell.estimateCellHeight(self.dataSource[indexPath.row].title!) + 20
    }
}
