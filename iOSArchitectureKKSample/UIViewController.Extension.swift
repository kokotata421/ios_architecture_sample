//
//  UIViewController.Extension.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/08/19.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

extension UIViewController: ExtensionCompatible {}

extension Extension where Base: UIViewController {
    var showedViewController: UIViewController? {
        switch self.base {
        case let naviVC as UINavigationController:
            return naviVC.visibleViewController
        case let tabVC as UITabBarController:
            return tabVC.selectedViewController
        default:
            return self.base.presentedViewController
        }
    }
}
