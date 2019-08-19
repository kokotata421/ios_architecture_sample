//
//  SearchUseCase.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

enum Category: Int {
    case animal
    case travel
    case fashion
}

protocol SearchUsecaseInputPort: PhotoSelectable {
    func slideCategoryView(up: Bool)
    func fetchCategoryPhotos()
    func searchPhotos(query: String)
}

protocol SearchUsecaseOutputPort: PhotoTransitionable {
    func setupCategoryPhotos(photos: [PhotoObject])
    func slideCategoryView(up: Bool)
    func showSearchResult(photos: [PhotoObject])
}

