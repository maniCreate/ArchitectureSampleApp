//
//  EntryListPresenter.swift
//  APIClient-MVP
//
//  Created by Syunsuke Nakao on 2019/06/13.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import Foundation

class EntryListPresenter {
    
    private weak var view: ListView?
    
    private let listModel: EntryListModel
    
    var entriesList: [Entry] {
        return listModel.entryListData
    }
    
    var numberOfEntries: Int {
        return listModel.dataCount()
    }
    
    init(view: ListView) {
        self.view = view
        self.listModel = EntryListModel()
        listModel.delegate = self
    }
    
    func fetchList() {
        listModel.fetchData()
    }
    
}

extension EntryListPresenter: EntryListModelDelegate {
    
    func didFinishFetchData() {
        view?.fetchListData()
    }
    
}
