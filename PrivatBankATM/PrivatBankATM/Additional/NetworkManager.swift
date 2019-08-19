//
//  NetworkManager.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let url = URL(string: "https://api.privatbank.ua/p24api/infrastructure?json&atm&address=&city=")
    
    func fetchData(clouser: @escaping ()->()) {
        //let parsedResult: DataATMResponse = try? JSONDecoder().decode(DataATMResponse.self, from: <#T##Data#>)
    }
}
