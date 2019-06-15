//
//  ViewController.swift
//  APIClient-MVC
//
//  Created by Syunsuke Nakao on 2019/06/13.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EntryListModelDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let listModel = EntryListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        listModel.delegate = self
        
        listModel.fetchData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.dataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let content = listModel.entryListData[indexPath.row]
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.setImage(fromUrl: content.authorImageUrl)
        
        let title = cell.contentView.viewWithTag(2) as! UILabel
        title.text = content.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func didFinishReloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        listModel.fetchData()
        sender.endRefreshing()
    }
    
    
}

