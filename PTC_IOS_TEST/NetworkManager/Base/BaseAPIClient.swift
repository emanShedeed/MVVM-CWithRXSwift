//
//  BaseAPIClient.swift
//  NetworkLayerSample
//
//  Created by Ismail Ahmed on 12/18/18.
//  Copyright © 2018 LinkDev. All rights reserved.
//
import Alamofire

class BaseAPIClient {
    
    // in case there is SSL Pinning, uncomment next lines, remove the ":", and change domain (N.B: Do not forget to add the certificate file to the app and specify its target):
    
    private static let serverTrustPolicies: [String: ServerTrustManager] = [
        //        "temp.domain.com": .pinPublicKeys(
        //            publicKeys: ServerTrustPolicy.publicKeys(),
        //            validateCertificateChain: false,
        //            validateHost: true
        //        )
        :
    ]
    
    private static let sessionManager = Session(
        
        //        serverTrustPolicyManager: ServerTrustPolicyManager(
        //            policies: serverTrustPolicies
        //        )
    )
    
    static func performRequest<T:Decodable>(route: RouterRequestConvertible, decoder: JSONDecoder = JSONDecoder(), completion: ((_ result: Result<T,Error>,_ statusCode:Int) -> Void)?) {
        
        AF
            .request(route)
            .validate()
            .responseJSON(completionHandler: { response in
//                print(String(data: response.data! , encoding: .utf8))
                let statusCode = response.response?.statusCode ?? -1
                switch response.result {
                case .success:
                    do {
                        if let value = (try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)) as? T {
                            print(value)
                            completion?(.success(value), statusCode)
                        }else{
                            let variable = try decoder.decode(T.self, from: response.data!)
                            print(variable)
                            completion?(.success(variable), statusCode)
                            
                        }
                    } catch {
                        completion?(.failure(error), statusCode)
                    }
                    
                case .failure(let error):
                    completion?(.failure(error), statusCode)
                }
                
            })
        
    }
    
    static func uploadMultiPartData<T:Decodable>(endUrl: String, fileURL: URL, parameters: [String : Any]?, completion: ((_ result: Result<T,Error>) -> Void)?) {
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        var image:UIImage?
        var dataToBeSend:Data?
        AF.upload(multipartFormData: { (multipartFormData) in
            if let parms=parameters{
                for (key, value) in parms  {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            
            // let fileData = try! Data(contentsOf:fileURL)
            guard let fileData = try? Data(contentsOf: fileURL) else {
                print("There was an error!")
                // return or break
                return
            }
            let filename : String = fileURL.lastPathComponent
            let splitName:[String] = filename.components(separatedBy: ".")
            let name = splitName.first
            let filetype = splitName.last
            if filetype?.uppercased() != "PDF"{
                image=UIImage(data: fileData)
                dataToBeSend = image!.jpegData(compressionQuality: 0.2)!
            }else{
                dataToBeSend=fileData
            }
            
            if let data = dataToBeSend{
                multipartFormData.append(data, withName: "\(name ?? "name")", fileName: "\(filename)", mimeType: "\(name ?? "name")/\(filetype ?? "jpg")")
            }
            
        }, to: endUrl, usingThreshold:0, method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON(completionHandler: { response in
                //  defer{SVProgressHUD.dismiss()}
                print("resp is \(response)")
                
                //Do what ever you want to do with response
            })
        
    }
    static func uploadMultiPartData<T:Decodable>(url: String, imageData: Data,fileName: String,mimeType: String = "image/png", parameters: [String : Any]?, token: String?, decoder: JSONDecoder = JSONDecoder(), completion: ((_ result: Result<T,Error>) -> Void)?) {
        var headers: HTTPHeaders
        if let token = token {
             headers = [
                "Authorization": token ,
                "Content-type": "multipart/form-data"
            ]} else {
             headers = [
                "Content-type": "multipart/form-data"
            ]
        }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            if let parms=parameters{
                for (key, value) in parms  {
                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            multipartFormData.append(imageData, withName: "\(fileName)", fileName: "\(fileName)", mimeType: mimeType)
        }, to: url, usingThreshold:0, method: .post, headers: headers).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON(completionHandler: { response in
                //  defer{SVProgressHUD.dismiss()}
                switch response.result {
                case .success:
                    do {
                        if let value = (try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)) as? T {
                            print(value)
                            completion?(.success(value))
                        }else{
                            let variable = try decoder.decode(T.self, from: response.data!)
                            print(variable)
                            completion?(.success(variable))
                            
                        }
                    } catch {
                        completion?(.failure(error))
                    }
                case .failure(let error):
                    completion?(.failure(error))
                    
                }
                print("resp is \(response)")
                
                //Do what ever you want to do with response
            })
        
    }
    
    
}
