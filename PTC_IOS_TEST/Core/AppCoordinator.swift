//
//  Coordinator.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var window:UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
    }
    
    func start() {
        let customSplashCoordinator = CustomSplashCoordinator(window: window)
        childCoordinators.append(customSplashCoordinator)
        customSplashCoordinator.start()
        
    }
}
