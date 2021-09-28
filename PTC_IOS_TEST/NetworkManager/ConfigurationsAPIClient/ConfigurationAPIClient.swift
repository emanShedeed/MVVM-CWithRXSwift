//
//  ArticlesAPIClient.swift
//  Network-Layer
//
//  Created by gody on 8/5/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import Foundation
import Alamofire

class ConfigurationAPIClient {
    
    static func fetchBasicConfigurations(completion: ((_ result: Result<ConfigurationResponse,Error>,_ statusCode:Int) -> Void)?) {
        BaseAPIClient.performRequest(route: ConfigurationAPIRouter.fetchBasicConfigurations, completion: completion)
    }
    
}



fileprivate enum ConfigurationAPIRouter : RouterRequestConvertible
    
{
    case fetchBasicConfigurations
    
    var method: HTTPMethod {
        switch self {
        case .fetchBasicConfigurations:
            return .get
   
        }
    }
    
    var endPoint: EndPoint {
        switch self {
        case .fetchBasicConfigurations:
            return APIs.Configurations.fetchBasicConfigurations
        }
    }
    
    var queryItems: QueryItems? {
        switch self {
        case .fetchBasicConfigurations:
            return nil
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchBasicConfigurations:
            return nil
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default :
            return nil
            
        }
    }
    
}

