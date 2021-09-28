//
//  RouterRequestConvertible.swift
//  NetworkLayerSample
//
//  Created by Ismail Ahmed on 12/18/18.
//  Copyright © 2018 LinkDev. All rights reserved.
//

import Alamofire
typealias QueryItems = [String : String]
protocol RouterRequestConvertible: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var endPoint: EndPoint { get }
    var queryItems: QueryItems? { get }
    var headers: [String:String]? { get }
    var parameters: Parameters? { get }
    var environment : Environment { get }
    
}

extension RouterRequestConvertible {
    
    private var baseHeaders : [String : String] {
        return [
            "Content-Type" : "application/json",
            "Accept" : "text/plain"
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        // URL Components
        var components = environment.components
        components.path = endPoint.subdomain + endPoint.path
        print(components.path)
        var items = [URLQueryItem]()
        queryItems?.forEach {
            items.append(URLQueryItem(name: $0, value: $1)) }
        if items.count != 0  {
            components.queryItems = items
        }
        // Request
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        let reqHeaders = baseHeaders + environment.headers + headers
        reqHeaders.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }
        
        //        // Parameters
        if let parameters = parameters {
            do {
                //let data = (try JSONSerialization.data(withJSONObject: parameters, options: []))
                //  print(String(data: data, encoding: .utf8)!)
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        print (urlRequest.url as Any)
        return urlRequest
    }
    
    var environment : Environment {
        return .staging
    }
}


private extension Dictionary {
    /**
     this function enable override + operator to add dictionaries dixtionaries.
     */
    static func +(lhs: Dictionary, rhs: Dictionary?) -> Dictionary {
        if rhs == nil {
            return lhs
        } else {
            var dic = lhs
            rhs!.forEach { dic[$0] = $1 }
            return dic
        }
    }
}
extension Encodable {
    /**
     this function convert object to JSON with formate [String: Any].
     
     */
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        print(String(data: data, encoding: .utf8)!)
        print((try? JSONSerialization.jsonObject(with: data, options: [])) as! [String: Any])
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
}
