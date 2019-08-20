//
//  Ext-SavedViewController+TableView.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/20/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import UIKit

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchViewModel?.savedDataATMResponse.devices.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedTableViewCell", for: indexPath) as! SavedTableViewCell
        
        guard let elem = searchViewModel?.savedDataATMResponse.devices else { return cell }
        cell.cellLabel.text = elem[indexPath.row].fullAddressRu
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Delet row")
            
            self.searchViewModel?.savedDataATMResponse.devices.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
