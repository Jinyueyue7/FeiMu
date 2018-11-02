//
//  ViewController.swift
//  FeiMu
//
//  Created by 金悦悦 on 2018/11/2.
//  Copyright © 2018年 金悦悦. All rights reserved.
//

import UIKit
import SBCycleScrollView
import IQKeyboardManagerSwift
import ESPullToRefresh
import Moya
import Moya_SwiftyJSONMapper
import ObjectMapper
import Result
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.shared.enable = true
        
        //测试轮播图
        let cycleScrollView = CycleScrollView.initScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200), imageNamesGroup: ["Image1","Image2","Image3"], cycleOptions: CycleOptions())
        view.addSubview(cycleScrollView)
        
        let cycleScrollView1 = CycleScrollView.initScrollView(frame: CGRect(x: 0, y: 220, width: view.frame.width, height: 200), delegate: self, placehoder: UIImage(named: "Image1"), cycleOptions: CycleOptions())
        view.addSubview(cycleScrollView1)
        
        cycleScrollView1.imageURLStringsGroup = ["http://pic33.photophoto.cn/20141022/0019032438899352_b.jpg","http://img.zcool.cn/community/010a1b554c01d1000001bf72a68b37.jpg@1280w_1l_2o_100sh.png","http://img.zcool.cn/community/012b245544ebd60000019ae93e4e4b.jpg@1280w_1l_2o_100sh.jpg"]
        
        let textField = UITextField(frame: CGRect(x: 0, y: view.frame.maxY - 100, width: view.frame.width, height: 50))
        textField.backgroundColor = UIColor.yellow
        view.addSubview(textField)
        
        view.addSubview(tableView)
        //下拉刷新
        tableView.es.addPullToRefresh {
            [unowned self] in
            
            self.tableView.es.stopPullToRefresh()
            ///// 设置ignoreFooter来处理不需要显示footer的情况
            self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            
        }
        
        //上拉加载更多
        tableView.es.addInfiniteScrolling {
            //如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
            self.tableView.es.stopLoadingMore()
            //通过noticeNoMoreData设置footer暂无数据状态
            self.tableView.es.noticeNoMoreData()
            
        }
        
        CommentProvider.request(.recommendList) { result in
            print(result)
            
            if case let .success(response) = result {
               print(response)
            }
        }
    }
}

extension ViewController :  CycleScrollViewDelegate {
    
    func didSelectedCycleScrollView(_ cycleScrollView: CycleScrollView, _ Index: NSInteger) {
        print("点击了第\(Index)个")
    }
    
}

