//
//  EntryListModel.swift
//  APIClient-MVVM
//
//  Created by Syunsuke Nakao on 2019/06/16.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire

class EntryListService {
    
    let urlString: String = "https://qiita.com/api/v2/items/"
    
    func fetchEntryList() -> Observable<[Entry]?> {
        return RxAlamofire.requestJSON(.get, urlString).map { (_, json) in
            self.parseEntryList(json: json)
        }
    }
    
    private func parseEntryList(json: Any) -> [Entry]? {
        if let entryListJson = json as? [Any] {
            let entryList = entryListJson.map { (data) -> Entry in
                let entryData = data as? [String: Any]
                let entry = Entry(entryData!)
                return entry
            }
            return entryList
        }
        return nil
    }
    
}
