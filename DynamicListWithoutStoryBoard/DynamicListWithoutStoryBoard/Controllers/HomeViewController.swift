//
//  HomeViewController.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        // Do any additional setup after loading the view.
    }
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.view = view
        
    }
}
