//
//  ViewController.swift
//  APIClient-MVVM
//
//  Created by Syunsuke Nakao on 2019/06/13.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refresh = UIRefreshControl()
    
    var entryListViewModel: EntryListViewModel = EntryListViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refresh
        
        //From ViewModel
        entryListViewModel.rx_entryList.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "cell")) { (i, entry, cell) in
                
                let imageView = cell.contentView.viewWithTag(1) as! UIImageView
                imageView.kf.setImage(with: URL(string: entry.authorImageUrl!))
                let title = cell.contentView.viewWithTag(2) as! UILabel
                title.text = entry.title
                
            }.disposed(by: disposeBag)
        
        
        
        //To ViewModel
        refresh.rx.controlEvent(.valueChanged).asDriver().drive(onNext: {
            self.entryListViewModel.getEntryData()
            self.refresh.endRefreshing()
        }).disposed(by: disposeBag)
        
        
        entryListViewModel.getEntryData()
    }
    
}
