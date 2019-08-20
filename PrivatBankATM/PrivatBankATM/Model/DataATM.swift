//
//  DataATM.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

struct DataATMResponse: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case devices
//    }
    var devices = [DataATM]()
}

struct DataATM: Decodable {
    var type : String
    var cityRU : String
    var cityUA : String
    var cityEN : String
    var fullAddressRu : String
    var fullAddressUa : String
    var fullAddressEn : String
    var placeRu : String
    var placeUa : String
    var latitude : String
    var longitude : String
    
}
