//
//  SearchViewController.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchViewModel: SearchViewModel?
    
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
        searchViewModel?.fetchData(clouser: {
            print("end")
        })
    }
    
    
    private func setupViews() {
        searchBarView.delegate = self
        
    }

}
