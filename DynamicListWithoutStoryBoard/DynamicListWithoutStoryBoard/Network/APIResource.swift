//
//  APIResource.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation

protocol ApiResource {
    //associatedtype Model
    var methodPath: String { get }
    var body: Dictionary<String,Any>?{get}
    //func makeModel(serialization: Serialization) -> Model
}

extension ApiResource {
    var url: URL {
        let url =  methodPath
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print("URL IS ::: \(String(describing: urlString))")
        return URL(string: urlString!)!
    }
}

struct GetListResource: ApiResource {
    var methodPath: String = APIMethods.getList.rawValue
    var body: Dictionary<String, Any>?
    
}
