//
//  Endpoints.swift
//  NetworkLayerSample
//
//  Created by Ismail Ahmed on 2/3/19.
//  Copyright © 2019 Ismail Ahmed. All rights reserved.
//

protocol EndPoint {
    var subdomain : String { get }
    var path: String { get }
}

struct APIs {
    
    enum Configurations: EndPoint {
        
        case fetchBasicConfigurations
        var subdomain: String{
            switch self {
           default:
                return "/"
            }
        }
        var path: String {
            switch self {
            case .fetchBasicConfigurations:
                 return "configurations/"
            }
        }

    }
    enum Products: EndPoint {
        
        case fetchProducts(keySearch:String, pageNo:String)
        case fetchProductById(id: String)
      
        var subdomain: String{
            switch self {
            case .fetchProducts:
                return "/search/"
            case.fetchProductById:
                return "/product/"
            }
        }
        var path: String {
            switch self {
            case .fetchProducts(let keySearch, let id):
                 return "\(keySearch)/page/\(id)/"
            case .fetchProductById(let id):
                return "\(id)/"
         
            }
        }

    }
    
}
