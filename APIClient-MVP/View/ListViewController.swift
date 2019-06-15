//
//  ViewController.swift
//  APIClient-MVP
//
//  Created by Syunsuke Nakao on 2019/06/13.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import UIKit

protocol ListView: class {
    func fetchListData()
}

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: EntryListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = EntryListPresenter(view: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        presenter.fetchList()
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        presenter.fetchList()
        sender.endRefreshing()
    }
    

}

extension ListViewController: ListView {
    
    func fetchListData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ListViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfEntries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let content = presenter.entriesList[indexPath.row]
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        imageView.setImage(fromUrl: content.authorImageUrl)
        
        let title = cell.contentView.viewWithTag(2) as! UILabel
        title.text = content.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

