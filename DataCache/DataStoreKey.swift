//
//  DataStoreKey.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/22.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import Foundation

// MARK: CacheKey
public protocol CacheKeys {
    associatedtype Value: CacheValue
    var rawValue: String { get }
    var defaultValue: Value? { get }
}

public class CacheKey<Value: CacheValue>: CacheKeys {
    public let rawValue: String
    public let defaultValue: Value?
    
    public init(_ rawValue: String, defaultValue: Value? = nil) {
        self.rawValue = rawValue
        self.defaultValue = defaultValue
    }
}
