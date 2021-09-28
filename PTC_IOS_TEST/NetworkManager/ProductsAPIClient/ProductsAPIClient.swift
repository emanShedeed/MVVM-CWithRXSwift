//
//  ProductsAPIClient.swift
//  PTC_IOS_TEST
//
//  Created by gody on 9/18/21.
//  Copyright © 2021 Jumia. All rights reserved.
//

import Foundation
import Alamofire
class ProductsAPIClient {
    
    static func fetchProducts(searchKey: String, pageNo: Int, completion: ((_ result: Result<Products,Error>,_ statusCode:Int) -> Void)?) {
        BaseAPIClient.performRequest(route: ProductsAPIRouter.fetchProducts(searchKey: searchKey, pageNo: pageNo), completion: completion)
    }
    static func fetchProductByID(id: String, completion: ((_ result: Result<ProductDetails,Error>,_ statusCode:Int) -> Void)?) {
        BaseAPIClient.performRequest(route: ProductsAPIRouter.fetchProductByID(id: id), completion: completion)
    }
 
    
}



fileprivate enum ProductsAPIRouter : RouterRequestConvertible
    
{
    
    case fetchProducts(searchKey: String, pageNo: Int)
    case fetchProductByID(id: String)

    
    var method: HTTPMethod {
        switch self {
        case .fetchProducts, .fetchProductByID:
            return .get
        }
    }
    
    var endPoint: EndPoint {
        switch self {
        case .fetchProducts(let searchKey, let pageNo):
            return APIs.Products.fetchProducts(keySearch: searchKey, pageNo: "\(pageNo)")
        case .fetchProductByID(let id):
            return APIs.Products.fetchProductById(id: id)
        }
    }
    
    var queryItems: QueryItems? {
        switch self {
        default:
            return nil

        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default :
            return nil
            
        }
    }
    
    struct Keys {
        //        static let articleId = "id"
    }
}

