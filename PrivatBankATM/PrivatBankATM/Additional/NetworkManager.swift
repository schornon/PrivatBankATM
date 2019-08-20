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
        guard let url = URL(string: "\(urlString)\(request)") else { print("guard fail"); return }
        print(url)
        Alamofire.request(url).responseJSON { (response) in
            print("Alamofire success")
            //print("++++++++++++++++++++++\(self.jsonToString(json: response as AnyObject))+++++++++++++++")
            guard let data = response.data else { return }
            //self.searchViewModel?.saveToDataOfArray(data: data)
            print("saved data: |\(data)|")
            do {
                let parsedResult = try JSONDecoder().decode(DataATMResponse.self, from: data)
                self.searchViewModel?.dataATMResponse = parsedResult
                self.searchViewModel?.saveToCoreData()
                //print(self.searchViewModel?.coreDataATMResponse)
                clouser()
                //self.searchViewModel?.convertDataToStruct()
            } catch {
                print("JSONDecoder failuer")
            }
        }
        
    }
    
    func jsonToString(json: AnyObject) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            let convertedString = String(data: data, encoding: .utf8)
            return convertedString!
        } catch let error {
            print(error)
        }
        return ""
    }
    
    
}
