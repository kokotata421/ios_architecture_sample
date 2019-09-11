//
//  ViewController.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import RxSwift
import KeychainAccess

//protocol UnsplashAuthenticationOutput where Self: UIViewController {
//    func openAuthenticationURL(_ url: URL, completionHandler completion: ((Bool) -> Void)?)
//}

class SplashViewController: UIViewController {
    
    lazy private var label: UILabel = {
        let label: UILabel = .init(frame: .zero)
        label.text = "splash"
        label.sizeToFit()
        label.center = self.view.center
        return label
    }()
    
    weak private var transitioner: SplashTransitioner!
    private let controller: SplashControllerProtocol
    let viewModel: SplashViewModelProtocol
    private let disposeBag: DisposeBag

    init(controller: SplashControllerProtocol,
         viewModel: SplashViewModelProtocol,
         disposeBag: DisposeBag = DisposeBag()) {
        self.controller = controller
        self.viewModel = viewModel
        self.disposeBag = disposeBag
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(label)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
  
}

extension SplashViewController: SplashTransitionerInjectable {
    func inject(transitioner: SplashTransitioner) {
        self.transitioner = transitioner
    }
}


