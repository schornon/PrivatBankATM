//
//  DataATM.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation

struct DataATMResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case devices
    }
    let devices: [DataATM]
}

struct DataATM: Decodable {
    var type : String?
    var cityRU : String?
    var cityUA : String?
    var cityEN : String?
    var fullAdressRu : String?
    var fullAdressUa : String?
    var fullAdressEn : String?
    var placeRu : String?
    var placeUa : String?
    var latitude : Double?
    var longitude : Double?
}
