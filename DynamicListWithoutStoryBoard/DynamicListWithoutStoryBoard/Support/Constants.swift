//
//  Constants.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 12/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import Foundation
import UIKit


let marginConstant: CGFloat = 10
let descriptionLabelMinHeight: CGFloat = 17
let profileImageViewHeigth: CGFloat = 60
let normalForntSize: CGFloat = 13
let boldFontSize: CGFloat = 15

enum AppConstants: String {
    case noData = "No data available"
    case cellIdentifier = "detailsCell"
    case EndpiontUrl
    case noResponse = "Something went wrong.\n Please try again"
    case error
    case downloading  = "Downloading data\n Please Wait..."
    case loading = "Loading..."
}
