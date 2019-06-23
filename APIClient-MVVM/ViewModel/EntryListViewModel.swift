//
//  EntryListViewModel.swift
//  APIClient-MVVM
//
//  Created by Syunsuke Nakao on 2019/06/16.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class EntryListViewModel {
    
    var rx_entryList = Variable([Entry]())
    
    private let service = EntryListService()
    
    var disposeBag = DisposeBag()
    
    func getEntryData() {
        service.fetchEntryList().subscribe(onNext: { (entryList) in
            guard let newList = entryList else {
                return
            }
            self.rx_entryList.value = newList
        }).disposed(by: disposeBag)
    }
    
}
