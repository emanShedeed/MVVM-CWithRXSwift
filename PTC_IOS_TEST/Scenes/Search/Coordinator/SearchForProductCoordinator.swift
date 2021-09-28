//
//  SearchCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
class SearchForProductCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController : UINavigationController?
    var window : UIWindow?
    
    init(window:UIWindow) {
        self.window = window
    }
    
    func start() {
        let searchVC = SearchViewController()
        navigationController = UINavigationController(rootViewController: searchVC)
        let searchForProductViewModel = SearchForProductViewModel()
        searchVC.viewModel = searchForProductViewModel
        searchForProductViewModel.coordinator = self
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func navigateToProductsVC(withSearchKey key: String) {
        let productsCoordinator = ProductsCoordinator(navigationcontroller: navigationController!, serachKey: key)
        childCoordinators.append(productsCoordinator)
         let backItem = UIBarButtonItem()
         backItem.title = "Something Else"
        productsCoordinator.start()
    }
}
