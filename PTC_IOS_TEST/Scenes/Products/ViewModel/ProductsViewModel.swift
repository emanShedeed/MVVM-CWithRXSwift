//
//  ProductsViewModel.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductsViewModel {
    
    public enum ProductsError {
        case NotFound(String)
    }
    
    
    public let products = BehaviorRelay<[ItemResult]>(value: [])
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<ProductsError> = PublishSubject()
    let fetchMoreProducts = PublishSubject<Void>()
    
    var coordinator : ProductsCoordinator?
    private let disposeBag = DisposeBag()
    var savedSearchKey: String = ""
    private var pageCounter = 1
    private var maxValue = 1
    private var limit = 10.0
    private var isPaginationRequestStillResume = false
    init() {
        bind()
    }
    
    private func bind() {
        
        fetchMoreProducts.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.requestProducts(searchKey: self.savedSearchKey, pageNo: self.pageCounter)
        }
        .disposed(by: disposeBag)
    }
    
    
    public func requestProducts(searchKey:String,pageNo:Int) {
        
        if isPaginationRequestStillResume { return }
        
        if pageCounter > maxValue  {
            isPaginationRequestStillResume = false
            return
        }
        isPaginationRequestStillResume = true
        
        self.loading.onNext(true)
        
        ProductsAPIClient.fetchProducts(searchKey: searchKey.lowercased(), pageNo: pageNo) {[weak self] result,statusCode in
            guard let self = self else {return}
            self.loading.onNext(false)
            switch result{
            case .success(let response):
                self.handleNavigation(response: response)
            case .failure(let failure):
                print(failure)
                if statusCode == 404{
                    self.error.onNext(.NotFound("Sorry, Product Not Found"))
                }
                }
            }
        }

    func getCurrency() -> String{
        let configurationObject = ConfigurationDataManager.shared.getData()
        let currencySymbol = configurationObject["currencySymbol"] as! String
        return currencySymbol
    }
    func handleNavigation(response:Products){
        let numberOfPages = Double(response.metadata?.totalProducts ?? 0) / self.limit
        self.maxValue = Int(numberOfPages.rounded(.toNearestOrAwayFromZero))
        self.pageCounter += 1
        self.isPaginationRequestStillResume = false
        let oldproducts = self.products.value
        let newProducts = response.metadata?.results ?? []
        self.products.accept(oldproducts + newProducts)
    }
    func navigateToProductDetailsVC(withId id: String) {
        coordinator?.navigateToProductDetailsVC(withId: id)
    }
    func popView() {
        coordinator?.popView()
    }
}
