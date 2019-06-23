//
//  Entry.swift
//  APIClient-MVVM
//
//  Created by Syunsuke Nakao on 2019/06/16.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import Foundation

struct Entry {
    
    var title: String?
    var authorImageUrl: String?
    var likesCount: Int?
    var pageView: Int?
    
    init(_ entryJson: [String: Any]) {
        
        self.title = entryJson["title"] as? String
        self.likesCount = entryJson["likes_count"] as? Int
        self.pageView = entryJson["page_views_count"] as? Int
        
        guard let user = entryJson["user"] as? [String: Any] else {
            self.authorImageUrl = nil
            return
        }
        
        self.authorImageUrl = user["profile_image_url"] as? String
        
    }
    
}
