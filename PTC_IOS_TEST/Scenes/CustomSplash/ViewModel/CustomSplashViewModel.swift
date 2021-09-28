//
//  ConfigurationViewModel.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa



class CustomSplashViewModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    var coordinator: CustomSplashCoordinator?
    
    public let configuration : PublishSubject<ConfigurationResponse> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<HomeError> = PublishSubject()
    
    public func requestData() {
        
        self.loading.onNext(true)
        ConfigurationAPIClient.fetchBasicConfigurations { [weak self] result, _ in
            guard let self = self else {return}
             self.loading.onNext(false)
                  switch result{
                  case .success(let returnJson):
                    print(returnJson)
                    self.configuration.onNext(returnJson)
                  case .failure(let error):
                      print(error)
                  }
              }
    }
    
    func navigateToSearchVC() {
        coordinator?.navigateToSearchForProductVC()
    }
}

