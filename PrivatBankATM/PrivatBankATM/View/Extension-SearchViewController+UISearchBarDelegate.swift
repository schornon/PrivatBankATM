//
//  Extension-SearchViewController+UISearchBarDelegate.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search ATM"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let source = searchViewModel.dataATMResponse.devices
        DispatchQueue.main.async {
            self.searchViewModel.filteredDataATMResponse.value.devices = source.filter({ (element: DataATM) -> Bool in
                return (element.fullAddressRu.lowercased().contains(searchText.lowercased()) || element.fullAddressEn.lowercased().contains(searchText.lowercased()) || element.fullAddressUa.lowercased().contains(searchText.lowercased()))
            })
            //print("filteredDataATMResponse: \(self.searchViewModel.filteredDataATMResponse.value.devices)===")
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        self.activityView.startSpinning(activityView)
        searchViewModel.fetchData(request: text) {
            self.tableView.reloadData()
            searchBar.text = ""
            self.activityView.stopSpinning(self.activityView)
        }
    }
    
    
}
