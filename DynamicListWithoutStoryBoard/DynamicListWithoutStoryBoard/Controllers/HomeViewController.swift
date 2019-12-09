//
//  HomeViewController.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var screenDetails: HomeScreenDetails?
    //var collectionView: UICollectionView = UICollectionView()
    var tableView: UITableView!
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.white
        //self.collectionView.frame = view.frame
        self.view = view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Welcome"
        self.tableView = UITableView()//UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "detailsCell")
        self.addCOnstrains()
        self.getList()
        // Do any additional setup after loading the view.
    }
    
    func addCOnstrains() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.topAnchor.constraint(equalToSystemSpacingBelow: self.view.topAnchor, multiplier: 1.0).isActive = true
        tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        self.view.backgroundColor = UIColor.red
        self.tableView.backgroundColor = UIColor.white
        self.tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
    }
}

extension HomeViewController {
    private func getList() {
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
                
                print("filtered rows:\(self.screenDetails?.rows.count)")
                self.tableView.reloadData()
            }
        }
        
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.screenDetails?.rows.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsTableViewCell
        if let rowData = self.screenDetails?.rows[indexPath.row] {
            cell.configCell(at: indexPath, rowData: rowData)
        }
        cell.layoutSubviews()
        return cell
    }
}
