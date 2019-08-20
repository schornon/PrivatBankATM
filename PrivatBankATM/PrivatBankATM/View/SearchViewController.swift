//
//  SearchViewController.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchViewModel = SearchViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchViewModel.getFromCoreData()
    }
    
    
    private func setupViews() {
        
        tableView.tableFooterView = UIView()
        activityView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        self.setupSearchController()
        
        searchViewModel.filteredDataATMResponse.bind { (_) in
            self.tableView.reloadData()
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        print("saveButtonPressed")
    }
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        searchViewModel.deleteAllData(entity: "CoreDataATM")
        print("leftButtonPressed: \(searchViewModel.coreDataATMResponse)")
    }
    
}
