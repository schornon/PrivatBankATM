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
    @IBOutlet weak var progressView: UIProgressView!
    
    
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
        searchViewModel.status.bind {
            if $0 == .failure {
                SharedClass.sharedInstance.alert(view: self, title: "Error", message: "Request has failed")
                self.progressView.isHidden = true
                self.progressView.progress = 0
            }
        }
        setRequestStatusBing()
    }
    
    private func setRequestStatusBing() {
        searchViewModel.requestProgress.bind {
            switch $0 {
            case .none:
                break
            case .stageOne:
                //self.activityView.startSpinning()
                self.set(progressView: self.progressView, withDuration: 1, toProgress: 0.25)
            case .stageTwo:
                self.set(progressView: self.progressView, withDuration: 7, toProgress: 0.55)
            case .stageThree:
                self.set(progressView: self.progressView, withDuration: 1, toProgress: 0.85)
            case .stageFour:
                //self.activityView.stopSpinning()
               self.set(progressView: self.progressView, withDuration: 1, toProgress: 1.0)
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        print("saveButtonPressed")
        performSegue(withIdentifier: "segueFromSearchToSaved", sender: self)
        
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
