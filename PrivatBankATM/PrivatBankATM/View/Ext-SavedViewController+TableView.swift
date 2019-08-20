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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "segueFromSavedToMap", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MapViewController {
            print("segue.destination is MapViewController")
            
            guard let indexPath = savedTableView.indexPathForSelectedRow else { return }
            savedTableView.deselectRow(at: indexPath, animated: true)
            guard let vc = segue.destination as? MapViewController else { return }
            //vc.searchViewModel = searchViewModel
            vc.atm = searchViewModel?.savedDataATMResponse.devices[indexPath.row]
        }
        
    }
    
}
