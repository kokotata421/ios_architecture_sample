//
//  ViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift

extension Notification.Name {
    static let transitionToMainTab = Notification.Name(rawValue: "toMainTab")
}

class SplashViewController: UIViewController {
    
    lazy private(set) var iconImageView: UIImageView = {
        let imageView: UIImageView = .init(image: #imageLiteral(resourceName: "splahIcon"))
        let size: CGSize = Const.Size.Splash.iconSize
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        let guide: UILayoutGuide = self.view.safeAreaLayoutGuide
        imageView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //Note: iconImageViewの中心YがTopから画面の高さ1/3の位置に配置されるように設定
        //Note: set the iconImageView's centerY on the one-third screen height from the top.
        let onethirdHeight: CGFloat = (self.view.frame.height - self.view.safeAreaInsets.bottom) / 3
        imageView.centerYAnchor.constraint(equalTo: guide.topAnchor, constant: onethirdHeight).isActive = true
        return imageView
    }()
    
    
    lazy private(set) var iconLabel: UILabel = {
        let label: UILabel = .init()
        label.text = "light"
        label.textColor = .white
        
        label.textAlignment = .center
        label.font = UIFont.init(name: "Hoefler Text", size: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.sizeToFit()
        let width: CGFloat = label.frame.width
        let height: CGFloat = label.frame.height
        
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        let distance: CGFloat = Const.Size.Splash.marginBetweenIconAndMainLabel
        label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: distance).isActive = true
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    let viewModel: SplashViewModelType
    private let disposeBag: DisposeBag

    init(viewModel: SplashViewModelType,
         disposeBag: DisposeBag = DisposeBag()) {
        self.viewModel = viewModel
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.08235294118, blue: 0.08235294118, alpha: 1)
        self.addObserverForTransition()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    private func setupViews() {
        _ = iconImageView
        _ = iconLabel
        
    }
    
    private func addObserverForTransition() {
        _ = NotificationCenter.default
            .addObserver(forName: .transitionToMainTab,
                         object: nil,
                         queue: nil,
                         using: transition(_:))
    }
    
    func prepareForMainTab() {
        viewModel.inputs.prepareForMainTab()
    }
    
    
    private func transition(_ : Notification) {
        viewModel.inputs.transition()
    }
  
}
