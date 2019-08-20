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
        self.tableView.reloadData()
    }
    
    
    private func setupViews() {
        
        tableView.tableFooterView = UIView()
        let imgView = UIImageView(image: UIImage(named: "swipeHelpImg"))
        imgView.center.x = tableView.tableFooterView!.center.x
        imgView.center.y = tableView.tableFooterView!.center.y + 50
        imgView.alpha = 0.6
        tableView.tableFooterView?.addSubview(imgView)
        
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
        performSegue(withIdentifier: "segueFromSearchToSaved", sender: self)
        
    }
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        searchViewModel.deleteAllData(entity: "CoreDataATM")
        print("leftButtonPressed: \(searchViewModel.coreDataATMResponse)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SavedViewController {
            print("segue.destination is SavedViewController")
            let vc = segue.destination as? SavedViewController
            vc?.searchViewModel = searchViewModel
            //print(vc?.searchViewModel?.savedDataATMResponse)
        }
    }
    
}
