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
        guard let req = request.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { self.searchViewModel?.status.value = .failure; return }
        guard let url = URL(string: "\(urlString)\(req)") else { print("guard URL fail"); self.searchViewModel?.status.value = .failure; return }
        print(url)
        searchViewModel?.requestProgress.value = .stageTwo
        Alamofire.request(url).responseJSON { (response) in
            print("Alamofire success")
            guard let data = response.data else { print("guard response.data error"); self.searchViewModel?.status.value = .failure; return }
            print("saved data: |\(data)|")
            self.searchViewModel?.requestProgress.value = .stageThree
            do {
                let parsedResult = try JSONDecoder().decode(DataATMResponse.self, from: data)
                if parsedResult.devices.isEmpty {
                    print("parsedResult.isEmpty")
                    self.searchViewModel?.status.value = .failure
                }
                self.searchViewModel?.dataATMResponse = parsedResult
                self.searchViewModel?.saveToCoreData()
                self.searchViewModel?.requestProgress.value = .stageFour
                clouser()
            } catch {
                print("JSONDecoder failuer")
                self.searchViewModel?.status.value = .failure
            }
        }
        
    }
    
}
