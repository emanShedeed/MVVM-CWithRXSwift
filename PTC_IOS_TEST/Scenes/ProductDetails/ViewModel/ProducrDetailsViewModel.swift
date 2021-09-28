//
//  ProducrDetailsViewModel.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailsviewModel {
    public enum ProductsError {
        case NotFound(String)
    }
    
    var coordinator : ProductDetailsCoordinator?
    public let productObject : PublishSubject<ProductDetails> = PublishSubject()
       public let mainProductImage : PublishSubject<String> = PublishSubject()
    public let productImages : PublishSubject<[String]> = PublishSubject()
    public let productBrand : PublishSubject<String> = PublishSubject()
    public let productName : PublishSubject<String> = PublishSubject()
    public let productSpecialPrice : PublishSubject<String> = PublishSubject()
    public let maxSavingPercentage : PublishSubject<String> = PublishSubject()
    public let productPrice : PublishSubject<NSAttributedString> = PublishSubject()
    public let rating : PublishSubject<Int> = PublishSubject()
    public let ratingsTotal : PublishSubject<String> = PublishSubject()
    public let description : PublishSubject<String> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<ProductsError> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    public func fetchProduct(with productId:String) {
        self.loading.onNext(true)
        
        ProductsAPIClient.fetchProductByID(id: productId) {[weak self] result,statusCode in
            guard let self = self else {return}
            self.loading.onNext(false)
            switch result{
            case .success(let response):
                if response.success ?? false {
                    self.publishNextValues(response: response)
                }else {
                    self.error.onNext(.NotFound("Sorry, Product Not Found"))
                }
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
    
    func publishNextValues(response: ProductDetails){
        productObject.onNext(response)
        mainProductImage.onNext(response.metadata?.imageList?.first ?? "")
        productImages.onNext(response.metadata?.imageList ?? [])
        productBrand.onNext(response.metadata?.brand ?? "")
        productName.onNext(response.metadata?.name ?? "")
        let specialPrice = getCurrency() + "\(response.metadata?.specialPrice ?? 0)"
        productSpecialPrice.onNext(specialPrice)
        let price = "\(getCurrency())\(response.metadata?.price ?? 0)".strikeThrough()
        productPrice.onNext(price)
        let savingPercentage = " -\(response.metadata?.maxSavingPercentage ?? 0)%"
        maxSavingPercentage.onNext(savingPercentage)
        rating.onNext(response.metadata?.rating?.average ?? 0)
        ratingsTotal.onNext("\(response.metadata?.rating?.ratingsTotal ?? 0) ratings")
        description.onNext(response.metadata?.summary?.shortDescription ?? "")
        
    }
    
    func popView() {
        coordinator?.popView()
    }
}
