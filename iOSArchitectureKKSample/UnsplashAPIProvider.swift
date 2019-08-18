//
//  UnsplashAPIRepository.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/05.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxMoya

struct UnsplashAPIProvider {
    static let provider: MoyaProvider<MultiTarget> = {
        let plugins: [Moya.PluginType] = {
            #if DEBUG
            let loggerPlugin: NetworkLoggerPlugin = .init(verbose: true)
            #endif
            //  Note: this plugin is for fetching Pagination links in photo items response header.
            let fetchPaginationLinksPlugin: NetworkActivityPlugin = .init(networkActivityClosure: {
                (change: NetworkActivityChangeType, target: TargetType) in
                guard let multiTarget = target as? MultiTarget else {
                    return
                }
                
                if  change == .ended,
                    let headers = target.headers,
                    let links = headers["Link"] {
                }
            })
            
            let accessTokenPlugin: AccessTokenPlugin = .init(tokenClosure: { () -> String in
                if let token = KeychainStore.unsplashToken {
                    return token
                } else {
                    return R.string.localizable.unsplashAPIClientID()
                }
            })
            
            #if DEBUG
            return [loggerPlugin,
                    fetchPaginationLinksPlugin,
                    accessTokenPlugin
            ]
            #else
            return [fetchPaginationLinksPlugin,
                    accessTokenPlugin
            ]
            #endif
            
        }()
        
        
        
        let provider = MoyaProvider<MultiTarget>(plugins: plugins)
        return provider
    }()
    
    static private func request<R>(_ target: R) -> Single<R.Response> where R: UnsplashAPITargetType {
        let target = MultiTarget(target)
        return provider.rx.request(target).map(R.Response.self)
    }
}

// MARK: Photo
extension UnsplashAPIProvider: UnsplashPhotoClient {
    static func requestPhotos() -> Single<UnsplashPhotosTarget.Response> {
        let target: UnsplashPhotosTarget = .init()
        return request(target)
    }
    
    static func requestLikePhoto(id: String, isLike: Bool) -> Single<UnsplashLikePhotoTarget.Response> {
        let target: UnsplashLikePhotoTarget = .init(id: id, like: isLike)
        return request(target)
    }
    
    static func requestDownloadPhotoURL(id: String) -> Single<UnsplashDownloadPhotoTarget.Response> {
        let target: UnsplashDownloadPhotoTarget = .init(id: id)
        return request(target)
    }
    
    static func requestSearchPhots(query: String) -> Single<UnsplashSearchPhotosTarget.Response> {
        let target: UnsplashSearchPhotosTarget = .init(query: query)
        return request(target)
    }
}

// MARK: Collection
extension UnsplashAPIProvider: UnsplashCollectionClient {
    static func requestCollection(id : String) -> Single<UnsplashCollectionTarget.Response> {
        let target: UnsplashCollectionTarget = .init(id: id)
        return request(target)
    }
    
    static func requestCollectionPhotos(id : String) -> Single<UnsplashCollectionPhotosTarget.Response> {
        let target: UnsplashCollectionPhotosTarget = .init(id: id)
        return request(target)
    }
    
    static func requestRelatedCollections(id : String) -> Single<UnsplashRelatedCollectionsTarget.Response> {
        let target: UnsplashRelatedCollectionsTarget = .init(id: id)
        return request(target)
    }
    
    static func requestEditPhotoInCollection(isAdding: Bool,
                                             collectionID: String,
                                             photoID: String) -> Single<UnsplashEditPhotoInCollectionTarget.Response> {
        let target: UnsplashEditPhotoInCollectionTarget = .init(isAdding: isAdding,
                                                                collectionID: collectionID,
                                                                photoID: photoID)
        return request(target)
    }
}

// MARK: Acount & User
extension UnsplashAPIProvider: UnsplashUserAccountClient {
    static func requestAccount() -> Single<UnsplashAccountTarget.Response> {
        let target: UnsplashAccountTarget = .init()
        return request(target)
    }
    
    static func requestUser(userName name: String) -> Single<UnsplashUserTarget.Response> {
        let target: UnsplashUserTarget = .init(userName: name)
        return request(target)
    }
    
    static func requestUserLikes(userName name: String) -> Single<UnsplashUserLikesTarget.Response> {
        let target: UnsplashUserLikesTarget = .init(userName: name)
        return request(target)
    }
    
    static func requestUserPortfolio(userName name: String) -> Single<UnsplashUserPortfolioTarget.Response> {
        let target: UnsplashUserPortfolioTarget = .init(userName: name)
        return request(target)
    }
    
    static func requestUserCollections(userName name: String) -> Single<UnsplashUserCollectionsTarget.Response> {
        let target: UnsplashUserCollectionsTarget = .init(userName: name)
        return request(target)
    }
}



