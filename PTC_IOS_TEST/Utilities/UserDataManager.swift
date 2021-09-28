//
//  UserDataManager.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/17/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation

class ConfigurationDataManager {
    
    static let shared = ConfigurationDataManager()
    private let userDefault = UserDefaults.standard
    
    private init() {}
    
//    var isLoggedIn: Bool {
//        ((getData()["userId"] as? String) != nil) ? true : false
//    }
//
    func cacheData(configurationInfo: [String: Any?]) {
       
        var configuration = [String: Any]()
        
        if !getData().isEmpty {
            configuration = getData()
        }
        if let currencySymbol = configurationInfo["currencySymbol"] {
            configuration["currencySymbol"] = currencySymbol
        }
        userDefault.setValue(configuration, forKey: "configuration")
        userDefault.synchronize()
    }
    
    func getData() -> [String: Any] {
        if let user = userDefault.value(forKey: "configuration") as? [String: Any] {
            return user
        } else {
            return [:]
        }
    }
}
