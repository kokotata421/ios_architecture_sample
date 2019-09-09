//
//  SplashPresenter.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/18.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SplashControllerProtocol: class {
    func fetchPopularPhotos(page: Int)
    func fetchCategoryPhotos()
    func fetchAccount()
}

extension SplashControllerProtocol {
    func fetchPopularPhotos(page: Int = 1) {
        
    }
}

protocol SplashPresenterProtocol: class {
}

final class SplashViewAdapter: SplashControllerProtocol, SplashPresenterProtocol {
    private let useCase: PrepareAppUseCaseInputPort
    private let disposeBag: DisposeBag
    
    lazy private(set) var popularPhotosObservable: Observable<UnsplashPhotosTarget.Response> = {
        return self.popularPhotosSubject.asObservable()
    }()
    private let popularPhotosSubject: PublishRelay<UnsplashPhotosTarget.Response> = .init()
    
    lazy private(set) var topPhotosObservable: Observable<UnsplashPhotosTarget.Response> = {
        return self.topPhotosSubject.asObservable()
    }()
    private let topPhotosSubject: PublishRelay<UnsplashPhotosTarget.Response> = .init()

    
    init (useCase: PrepareAppUseCaseInputPort,
          disposeBag: DisposeBag = DisposeBag()) {
        self.useCase = useCase
        self.disposeBag = disposeBag
    }
    
    func fetchPopularPhotos(page: Int = 1) {
        var popularPhotos: UnsplashPhotosTarget.Response = .init()
        var topPhotos: UnsplashPhotosTarget.Response = .init()
        useCase.fetchPopularPhotos(page: 1)
            .subscribe(onSuccess: { [weak self] photos in
                guard let self = self else { return }
                popularPhotos.append(contentsOf: photos)
                let appendedTopPhotos: UnsplashPhotosTarget.Response = photos.filter { $0.heightRatioToWidth <= 1.5
                    && $0.heightRatioToWidth >= 1.4 }
                topPhotos.append(contentsOf: appendedTopPhotos)
                if topPhotos.count >= 20 {
                    self.topPhotosSubject.accept(topPhotos)
                    self.popularPhotosSubject.accept(popularPhotos)
                } else {
                    self.fetchPopularPhotos(page: page + 1)
                }
            },
                       onError: { error in
                        #if DEBUG
                        log.debug(error)
                        #endif
            })
            .disposed(by: disposeBag)
    }
    
    func fetchCategoryPhotos() {
        Category.allCases.forEach {
            self.useCase.loadCategoryPhoto(<#T##category: Category##Category#>)
        }
    }
    
    func fetchAccount() {
        
    }
}
