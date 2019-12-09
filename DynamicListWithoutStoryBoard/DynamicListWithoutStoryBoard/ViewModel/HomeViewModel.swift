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
        
        request.loadWithData(httpMethod: .GET) { (response, statusCode, data) in
            if statusCode == 200, let data = data{
                guard let details = try? JSONDecoder().decode(HomeScreenDetails.self, from: data) else {return}
                print("Screen Details\(details.rows.count)")
                self.screenDetails = details
                self.screenDetails?.rows = details.rows.filter({ (row) -> Bool in
                    if row.title == nil && row.description == nil && row.imageHref == nil {
                        return false
                    }
                    return true
                })
                //print("filtered rows:\(String(describing: self.screenDetails?.rows.count))")
                completion(.Success(""))
                return
            }
             guard let error = response["error"] as? String else {
                guard let error = response["error"] as? NSError else {
                    completion(.Failed("Please try again"))
                    return
                }
                completion(.Failed(error.localizedDescription))
                return
            }
             completion(.Failed(error))
        }
        
    }
}
