//
//  HomeViewController.swift
//  DynamicListWithoutStoryBoard
//
//  Created by Raju@MFCWL on 08/12/19.
//  Copyright © 2019 RMS_Mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //var collectionView: UICollectionView = UICollectionView()
    var tableView: UITableView!
    var refreshController: UIRefreshControl!
    var isDownloading:Bool = false
    var viewModel: HomeViewModel = HomeViewModel()
    var placeHolderString: String = ""
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.white
        //self.collectionView.frame = view.frame
        self.view = view
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeHolderString = "Downloading..."
        self.tableView = UITableView()//UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
        self.tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "detailsCell")
        self.tableView.tableFooterView = UIView()
        self.addConstraints()
        self.addRefreshController()
        
        self.getList(isFromPullToRefresh: false)
        // Do any additional setup after loading the view.
    }
    
    func addConstraints() {
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
    
    internal func addRefreshController() {
        // Refresh Controller
        DispatchQueue.main.async {
            self.refreshController = UIRefreshControl()
            self.refreshController.attributedTitle = NSAttributedString(string: "")
            self.refreshController.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)
            self.tableView.addSubview(self.refreshController)
        }
        
    }
    @objc func refreshData() {
        if !self.isDownloading {
            self.getList(isFromPullToRefresh: true)
        }
    }
}

extension HomeViewController {
    internal func getList(isFromPullToRefresh: Bool) {
        self.isDownloading = true
        self.placeHolderString = "Please Wait..."
        self.viewModel.getList { [weak self](state) in
            guard let self = self else {return}
            self.isDownloading = false
            if isFromPullToRefresh {
                DispatchQueue.main.async {
                    self.refreshController.endRefreshing()
                }
            }
            switch state {
            case .Success(_):
                self.placeHolderString = "Loading.."
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.title = self.viewModel.screenDetails?.title
                }
            case .Failed(let msg):
                self.placeHolderString = msg
                print("Failed with \(msg)")
            default:
                break
            }
        }
    }
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.viewModel.screenDetails?.rows.count ?? 0
        let label = UILabel()
        label.textAlignment = .center
        label.text = self.placeHolderString
        self.tableView.backgroundView = count == 0 ? label : UIView()
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! DetailsTableViewCell
        if let rowData = self.viewModel.screenDetails?.rows[indexPath.row] {
            cell.configCell(at: indexPath, rowData: rowData)
        }
        cell.layoutSubviews()
        return cell
    }
}
