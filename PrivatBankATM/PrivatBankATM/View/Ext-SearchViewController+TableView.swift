//
//  Ext-SearchViewController+TableView.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/20/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return searchViewModel.filteredDataATMResponse.value.devices.count
        }
        return searchViewModel.dataATMResponse.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        DispatchQueue.main.async {
            var elem = DataATM(type: "empty", cityRU: "", cityUA: "", cityEN: "", fullAddressRu: "", fullAddressUa: "", fullAddressEn: "", placeRu: "", placeUa: "", latitude: "", longitude: "", tw: TimeWork())
            if self.isFiltering() && indexPath.row < self.searchViewModel.filteredDataATMResponse.value.devices.count {
                elem = self.searchViewModel.filteredDataATMResponse.value.devices[indexPath.row]
            } else if indexPath.row < self.searchViewModel.dataATMResponse.devices.count {
                elem = self.searchViewModel.dataATMResponse.devices[indexPath.row]
            }
            cell.cellLabel.text = elem.fullAddressRu
            
            if !self.searchViewModel.savedDataATMResponse.devices.contains(where: { $0.fullAddressRu == elem.fullAddressRu }) {
                cell.cellImageView.image = UIImage(named: "Favorit0")
            } else {
                cell.cellImageView.image = UIImage(named: "Favorit1")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
        
        if !searchViewModel.savedDataATMResponse.devices.contains(where: { $0.fullAddressRu == cell.cellLabel.text }) {
            cell.cellImageView.image = UIImage(named: "Favorit1")
            if isFiltering() {
                searchViewModel.savedDataATMResponse.devices.append(searchViewModel.filteredDataATMResponse.value.devices[indexPath.row])
            } else {
                searchViewModel.savedDataATMResponse.devices.append(searchViewModel.dataATMResponse.devices[indexPath.row])
            }
        } else {
            cell.cellImageView.image = UIImage(named: "Favorit0")
            searchViewModel.savedDataATMResponse.devices.removeAll(where: { $0.fullAddressRu == cell.cellLabel.text })
        }
        print(searchViewModel.savedDataATMResponse.devices)
    }
    
}
