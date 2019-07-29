//
//  HomeVCStore.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/07/26.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation


import Foundation
import RxCocoa
import RxSwift

final class SearchPhotoVCStore {
    static let shared = SearchPhotoVCStore()
    
    var photos: [Int] {
        return _selectedCategory.value
    }
    
    var photosObservable: Observable<[Int]> {
        return _selectedCategory.asObservable()
    }
    
    private let _selectedCategory = BehaviorRelay<[Int]> (value: [0])
    
    
    
    private let disposeBag = DisposeBag()
    
    init(dispatcher: SearchPhotoVCDispatcher = .shared) {
        dispatcher
            .photos
            .bind(to: _selectedCategory)
            .disposed(by: disposeBag)
        
        
    }
}
