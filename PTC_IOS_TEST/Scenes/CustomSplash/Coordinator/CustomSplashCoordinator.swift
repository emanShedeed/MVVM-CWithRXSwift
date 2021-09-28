//
//  customSplashCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit

class CustomSplashCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private let window: UIWindow
    private var customSplashVC: CustomSplashViewController?
    init(window: UIWindow) {
        self.window = window
        
    }
    
    func start() {
        let customSplashVC = CustomSplashViewController()
        let customSplashViewModel = CustomSplashViewModel()
        customSplashVC.viewModel = customSplashViewModel
        customSplashViewModel.coordinator = self
        self.customSplashVC = customSplashVC
        window.rootViewController = customSplashVC
        window.makeKeyAndVisible()
        
    }
    func navigateToSearchForProductVC(){
        let searchForProductCoordinator = SearchForProductCoordinator(window: self.window)
        childCoordinators.append(searchForProductCoordinator)
        searchForProductCoordinator.start()
        
    }
}
