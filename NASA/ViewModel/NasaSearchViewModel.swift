//
//  NasaSearchViewModel.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import Foundation
import RxSwift

class NasaSearchViewModel {
    
    public enum NetworkError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let listItems: PublishSubject<[ListItem]> = PublishSubject()
    public let selectedItem: PublishSubject<ListItem> = PublishSubject()
    public var selectedItemData: ListItem!
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<NetworkError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    
    public func requestData(){
        
        self.loading.onNext(true)
        Service.shared.fetchNasaImages { (result: Result<NasaSearch, ServiceError>) in
            self.loading.onNext(false)
            switch result {
                case .success(let listData):
                    let items = listData.collection.items
                    self.listItems.onNext(items)
                case .failure(let error):
                    switch error {
                        case .invalidEndpoint:
                            self.error.onNext(.serverMessage(errorMsgInvalidEndpoint))
                        case .invalidResponse, .decodeError:
                            self.error.onNext(.serverMessage(errorMsgInvalidResponse))
                        default:
                            self.error.onNext(.serverMessage(errorMsgUnknown))
                    }
            }
        }
        
    }
    
}

