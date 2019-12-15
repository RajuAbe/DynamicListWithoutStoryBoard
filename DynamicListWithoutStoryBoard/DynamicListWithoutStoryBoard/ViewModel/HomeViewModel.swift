//
//  HomeViewModel.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 09/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
// ViewModel
class HomeViewModel {
    var screenDetails: HomeScreenDetails?
}
extension HomeViewModel {
    internal func getList(completion: @escaping(_ networkSate: NetworkRequestState)-> Void) {
        let resource = GetListResource()
        let request = ApiRequest(resource: resource)
        
        request.loadWithData(httpMethod: .GET) {[weak self] (error, statusCode, data) in
            if statusCode == 200, let data = data{
                guard let details = try? JSONDecoder().decode(HomeScreenDetails.self, from: data) else {return}
                print("Screen Details\(details.rows.count)")
                self?.screenDetails = details
                self?.screenDetails?.rows = details.rows.filter({ (row) -> Bool in
                    /*
                     Filter rows 
                    if row.title == nil && row.description == nil && row.imageHref == nil {
                        return false
                    }
                     */
                    return true
                })
                completion(.Success(""))
                return
            }
            if let error = error {
                
                completion(.Failed(error.message))
                return
            }
            completion(.Failed(AppConstants.error.rawValue))
        }
        
    }
}
