//
//  HomeScreenDetails.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation

struct HomeScreenDetails: Codable {
    var title: String
    var rows:[Rows]
}

struct Rows: Codable {
    var title: String?
    var description: String?
    var imageHref: String?
}
