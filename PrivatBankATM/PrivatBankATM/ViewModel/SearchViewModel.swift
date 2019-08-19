//
//  SearchViewModel.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    var networkManager = NetworkManager()
    
    func fetchData(clouser: @escaping ()->()) {
        networkManager.fetchData(clouser: clouser)
    }
    
}
