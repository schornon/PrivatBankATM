//
//  NetworkManager.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    weak var searchViewModel: SearchViewModel?
    
    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }

    let urlString = "https://api.privatbank.ua/p24api/infrastructure?json&atm&address=&city="
    
    func fetchData(request: String, clouser: @escaping ()->()) {
        print("NetworkManager - fetchData")
        guard let req = request.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(urlString)\(req)") else { print("guard URL fail"); return }
        print(url)
        Alamofire.request(url).responseJSON { (response) in
            print("Alamofire success")
            guard let data = response.data else { return }
            print("saved data: |\(data)|")
            do {
                let parsedResult = try JSONDecoder().decode(DataATMResponse.self, from: data)
                self.searchViewModel?.dataATMResponse = parsedResult
                self.searchViewModel?.saveToCoreData()
                clouser()
            } catch {
                print("JSONDecoder failuer")
            }
        }
        
    }
    
}
