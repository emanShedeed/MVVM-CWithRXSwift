//
//  SearchForProductViewModel.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchForProductViewModel {
    
    public let searhBarText : PublishSubject<String> = PublishSubject()
    var coordinator: SearchForProductCoordinator?
    
    func navigateToProductsVC(withSearchKey key: String ){
        coordinator?.navigateToProductsVC(withSearchKey:key)
    }
}
