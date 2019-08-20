//
//  CDataATM.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import CoreData

//class CDataATMResponse : NSManagedObject {
//    
//    @NSManaged var devices = [CDataATM]()
//}


class CDataATM : NSManagedObject {
    
    @NSManaged var type : String
    @NSManaged var cityRU : String
    @NSManaged var cityUA : String
    @NSManaged var cityEN : String
    @NSManaged var fullAddressRu : String
    @NSManaged var fullAddressUa : String
    @NSManaged var fullAddressEn : String
    @NSManaged var placeRu : String
    @NSManaged var placeUa : String
    @NSManaged var latitude : String
    @NSManaged var longitude : String
    
    var dataATM : DataATM {
        get {
            return DataATM(type: self.type, cityRU: self.cityRU, cityUA: self.cityUA, cityEN: self.cityEN, fullAddressRu: self.fullAddressRu, fullAddressUa: self.fullAddressUa, fullAddressEn: self.fullAddressEn, placeRu: self.placeRu, placeUa: self.placeUa, latitude: self.latitude, longitude: self.longitude)
        }
        set {
            self.type = newValue.type
            self.cityRU = newValue.cityRU
            self.cityUA = newValue.cityUA
            self.cityEN = newValue.cityEN
            self.fullAddressRu = newValue.fullAddressRu
            self.fullAddressUa = newValue.fullAddressUa
            self.fullAddressEn = newValue.fullAddressEn
            self.placeRu = newValue.placeRu
            self.placeUa = newValue.placeUa
            self.latitude = newValue.latitude
            self.longitude = newValue.longitude
        }
    }
}
