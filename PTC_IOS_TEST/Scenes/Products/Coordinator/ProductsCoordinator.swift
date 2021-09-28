//
//  ProductsCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit

class ProductsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationcontroller: UINavigationController?
    var serachKey:String?
    
    init(navigationcontroller:UINavigationController,serachKey: String){
        self.navigationcontroller = navigationcontroller
        self.serachKey = serachKey
    }
    
    func start() {
        let productsVC = ProductsViewController()
        let productsViewModel = ProductsViewModel()
        productsVC.viewModel = productsViewModel
        productsVC.searchKey = serachKey
        productsViewModel.coordinator = self
        navigationcontroller?.pushViewController(productsVC, animated: false)
    }
    
    func navigateToProductDetailsVC(withId id: String) {
        let productDetailsCoordinator = ProductDetailsCoordinator(navigationController: navigationcontroller!, productId: id)
        childCoordinators.append(productDetailsCoordinator)
        productDetailsCoordinator.start()
    }
    
    func popView() {
         self.navigationcontroller?.popViewController(animated: false)
    }
}
