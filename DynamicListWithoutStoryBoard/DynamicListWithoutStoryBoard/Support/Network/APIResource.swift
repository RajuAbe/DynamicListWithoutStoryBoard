//
//  APIResource.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
/**
 API Respurce protocol
    - Variable methodPath: url method path
    - body: request body
 */
protocol ApiResource {
    //associatedtype Model
    var methodPath: String { get }
    var body: Dictionary<String,Any>?{get}
}

extension ApiResource {
    var url: URL {
        
        let url =  Utilities.endPointUrl+methodPath //add base url here..
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        //print("URL IS ::: \(String(describing: urlString))")
        return URL(string: urlString!)!
    }
}
/**
    Get list api resopurce 
 */
struct GetListResource: ApiResource {
    var methodPath: String = APIMethods.getList.rawValue
    var body: Dictionary<String, Any>?
    
}
