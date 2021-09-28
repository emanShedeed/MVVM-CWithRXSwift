//
//  CustomSplashViewController.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class CustomSplashViewController: UIViewController {
    
    var viewModel : CustomSplashViewModel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel.requestData()
        setupBindings()
        navigateToSearchVC()
    }

    // MARK: - Bindings
    
    private func setupBindings() {
        
        // binding loading to vc
                 
        viewModel.loading
                     .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        viewModel.configuration.subscribe(onNext:{ value in
            let configurationObject : [String: Any] = ["currencySymbol" : value.metadata?.currency?.currencySymbol as Any]
            ConfigurationDataManager.shared.cacheData(configurationInfo: configurationObject)
        }).disposed(by: disposeBag)

    }
    func navigateToSearchVC() {
        viewModel.configuration.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.navigateToSearchVC()
            }).disposed(by: disposeBag)
    }
   
}
