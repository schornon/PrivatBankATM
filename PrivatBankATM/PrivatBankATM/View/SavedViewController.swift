//
//  SavedViewController.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/20/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var savedTableView: UITableView!
    
    weak var searchViewModel : SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        
        savedTableView.tableFooterView = UIView()
        savedTableView.delegate = self
        savedTableView.dataSource = self
    }

}
