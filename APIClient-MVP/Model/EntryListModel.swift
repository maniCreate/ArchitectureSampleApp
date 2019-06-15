//
//  EntryListModel.swift
//  APIClient-MVP
//
//  Created by Syunsuke Nakao on 2019/06/13.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import Foundation

protocol EntryListModelDelegate: class {
    func didFinishFetchData()
}

class EntryListModel {
    
    let urlString: String = "https://qiita.com/api/v2/items/"
    
    var entryListData: [Entry] = [] {
        didSet {
            delegate?.didFinishFetchData()
        }
    }
    
    weak var delegate: EntryListModelDelegate?
    
    func fetchData() {
        
        let url = URL(string: urlString)
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [Any]
                
                self.entryListData = json.map { (article) -> Entry in
                    
                    let entryData:[String:Any] = article as! [String: Any]
                    
                    let title = entryData["title"] as? String
                    let likesCount = entryData["likes_count"] as? Int
                    let pageView = entryData["page_views_count"] as? Int
                    
                    let userInfo = entryData["user"] as? [String:Any]
                    let imageUrl = userInfo!["profile_image_url"] as? String
                    
                    let entry: Entry = Entry(
                        title: title,
                        authorImageUrl: imageUrl,
                        likesCount: likesCount,
                        pageView: pageView
                    )
                    
                    return entry
                }
                
            } catch {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    
    func dataCount() -> Int {
        return entryListData.count
    }
    
    
}
