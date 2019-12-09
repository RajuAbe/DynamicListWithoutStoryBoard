//
//  NetworkRequest.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
import UIKit

// MARK:- HTTP methods enum
enum HTTPMethods: String {
    case POST
    case GET
    case PUT
    case DELETE
}

// MARK:- Network Request protocol
protocol NetworkRequest: class {
    //associatedtype Model
    func loadWithData(httpMethod: HTTPMethods, withCompletion completion: @escaping (_ fullResponse: NSDictionary, _ statusCode:Int,_ data: Data?) -> Void)
    
}

extension NetworkRequest {
    /**
     Network request call
     
     - Parameter request: URL Request
     - Parameter Data: response in dictionary format
     - Parameter statusCode: HTTP Status code in Int format
     - Parameter data: response in Data format(optional)
     
     */
    fileprivate func loadWithRequest(withRequest request:URLRequest, withCompletion completion: @escaping (_ Data: NSDictionary, _ statusCode:Int, _ data: Data?) -> Void) {
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let dataTask = session.dataTask(with: request, completionHandler: {(data, urlResponse, error) in
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                if let eror = error {
                    completion(["error":eror], 500, nil)
                    return
                }
                completion(["error":"Please try again"], 500, nil)
                return
            }
            
            guard let resposeData = data else {
                guard let error = error else {
                    completion(["error":"No Error No Data"], httpResponse.statusCode, nil)
                    return
                }
                completion(["error":error], httpResponse.statusCode, nil)
                return
            }
            do {
               let responseStrInISOLatin = String(data: resposeData, encoding: String.Encoding.isoLatin1)
               guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                completion(["error":"could not convert data to UTF-8 format"], httpResponse.statusCode, resposeData)
                     print("could not convert data to UTF-8 format")
                     return
                }
                //let dict = ["data":""]
                //completion(dict as NSDictionary, httpResponse.statusCode, modifiedDataInUTF8Format)
                
                guard let responseDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: [.allowFragments]) as? [String:Any] else {
                    guard let resp = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format, options: [.allowFragments]) as? NSArray else {
                        completion(["error":"Not able to read Data"], httpResponse.statusCode, modifiedDataInUTF8Format)
                        return
                    }
                    let dict = ["data":resp]
                    completion(dict as NSDictionary, httpResponse.statusCode, modifiedDataInUTF8Format)
                    return
                }
                completion(responseDict as NSDictionary, httpResponse.statusCode, modifiedDataInUTF8Format)
                
            }
            catch let eror as NSError {
                completion(["error":eror], httpResponse.statusCode, nil)
            }
            
            
        })
        dataTask.resume()
    }
}
// MARK:- API Request
class ApiRequest<Resource: ApiResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequest {
    func loadWithData(httpMethod: HTTPMethods, withCompletion completion: @escaping (NSDictionary, Int, Data?) -> Void) {
        var request = URLRequest(url: resource.url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        if let reqData = resource.body {
            let jsonData = try! JSONSerialization.data(withJSONObject: reqData, options: [.prettyPrinted])
            if let str = String(data: jsonData, encoding: String.Encoding.utf8){
                print("\n\n JSON STring: " + str)
            }
            // print(reqData)
            request.httpBody = try! JSONSerialization.data(withJSONObject: reqData, options: [])
        }
        
        print(">>>>>>>\(request)")
        loadWithRequest(withRequest: request, withCompletion: completion)
        
    }
}

// MARK:- Network request state
enum NetworkRequestState {
    case Success(String?)
    case Failed(String)
    case NoInternet(String)
    case NoAuthentication
}


