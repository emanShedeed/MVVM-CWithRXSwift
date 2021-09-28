
//
//  ProductDetailsCoordinator.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import UIKit
class ProductDetailsCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    var productId: String?
    
    init(navigationController:UINavigationController,productId: String) {
        self.navigationController = navigationController
        self.productId = productId
    }
    
    func start() {
        let productDetailsViewController = ProductDetailsViewController()
        productDetailsViewController.productId = productId
        let productDetailsviewModel = ProductDetailsviewModel()
        productDetailsViewController.viewModel = productDetailsviewModel
        productDetailsviewModel.coordinator = self
        self.navigationController?.pushViewController(productDetailsViewController, animated: false)
    }
    
    func popView() {
        self.navigationController?.popViewController(animated: false)
    }
}
