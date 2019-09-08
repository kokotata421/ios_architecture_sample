//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

protocol SplashControllerProtocol: class {
    func fetchPopularPhotos()
    func fetchCategoryImages()
    func fetchAccount()
}

protocol SpalashPresenterProtocol: class {
    var viewModel: SplashViewModelProtocol { get }
}

final class SplashViewAdapter: SplashControllerProtocol {
    private let useCase: PrepareAppUseCaseInputPort
    
    init (useCase: PrepareAppUseCaseInputPort) {
        self.useCase = useCase
    }
    
    func fetchPopularPhotos() {
        useCase.fetchPopularPhotos(page: 1, photoEntities: [UnsplashPhotoEntity]())
    }
    
    func fetchCategoryImages() {
        useCase.searchPhotos(query: Category.allCases, page: 1)
    }
    
    func fetchAccount() {
        
    }
}

final class SplashViewPresenter: PhotoPrepareUseCaseOutputPort {
    let viewModel: SplashViewModelProtocol
    
    init(viewModel: SplashViewModelProtocol) {
        self.viewModel = viewModel
    }
    func setTopImages(_ images: [UnsplashPhotoEntity]) {
        
    }
    
    func setCategoryImage(_ image: [Category : UnsplashPhotoEntity]) {
        
    }
}
