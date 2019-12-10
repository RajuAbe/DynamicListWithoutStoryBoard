//
//  Constants.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation

// API methods
enum APIMethods: String {
    case getList = ""
}
// MARK: Plists
enum Plists: String {
    case PlistType = "plist"
    case Info
}
class Utilities {
    
    // Base URL
    static var endPointUrl: String {
            guard let env = stringResourceForID(resourceID: "EndpiontUrl", plistResource: Plists.Info.rawValue) else {
                return ""
            }
            return env
        }
}
extension Utilities {
    /**
     reading resources from plist file
     - parameter resourceID: resouceID(Key) which you wanted to read data
     - parameter plistResource: Plist file name
     - returns: string value(optional)
    */
    static func stringResourceForID(resourceID: String, plistResource: String) -> String? {
        guard let path = Bundle.main.path(forResource: plistResource, ofType: Plists.PlistType.rawValue) else {return nil}
        guard let myDict = NSDictionary(contentsOfFile: path) else {return nil}
        guard let val = myDict[resourceID] as? String else {return nil}
        return val
    }
}
