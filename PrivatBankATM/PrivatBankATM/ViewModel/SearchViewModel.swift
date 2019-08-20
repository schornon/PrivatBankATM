//
//  SearchViewModel.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SearchViewModel {
    
    var networkManager : NetworkManager?
    
    var dataATMResponse = DataATMResponse()
    var filteredDataATMResponse : Box<DataATMResponse> = Box(DataATMResponse())
    var savedDataATMResponse = DataATMResponse()
    
    var coreDataATMResponse = [NSManagedObject]()
    var coreDataOfArray = [NSManagedObject]()
    
    
    init() {
        self.networkManager = NetworkManager(searchViewModel: self)
    }
    
    func fetchData(request: String, clouser: @escaping ()->()) {
        print("SearchViewModel - fetchData")
        networkManager!.fetchData(request: request, clouser: clouser)
    }
    
    func saveToCoreData() {
        self.deleteAllData(entity: "CoreDataATM")
        print("coreDataATMResponse after dellAll : \(coreDataATMResponse)")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext

        //let entity = NSEntityDescription.entity(forEntityName: "CoreDataATMResponse", in: managedContext)!
        //let data = NSManagedObject(entity: entity, insertInto: managedContext)
        
        
        for d in self.dataATMResponse.devices {
            let entity2 = NSEntityDescription.entity(forEntityName: "CoreDataATM", in: managedContext)!
            let data2 = NSManagedObject(entity: entity2, insertInto: managedContext)
            data2.setValue(d.type, forKey: "type")
            data2.setValue(d.cityEN, forKey: "cityEN")
            data2.setValue(d.cityUA, forKey: "cityUA")
            data2.setValue(d.cityRU, forKey: "cityRU")
            data2.setValue(d.fullAddressEn, forKey: "fullAddressEn")
            data2.setValue(d.fullAddressUa, forKey: "fullAddressUa")
            data2.setValue(d.fullAddressRu, forKey: "fullAddressRu")
            data2.setValue(d.latitude, forKey: "latitude")
            data2.setValue(d.longitude, forKey: "longitude")
            data2.setValue(d.placeRu, forKey: "placeRu")
            data2.setValue(d.placeUa, forKey: "placeUa")
            //print("managedObject 'data2' : \(data2)")
            
            do {
                try managedContext.save()
                coreDataATMResponse.append(data2)
            } catch let error as NSError {
                print("save to coreData error \(error)")
            }
            self.filteredDataATMResponse.value = self.dataATMResponse
            
        }
        
        //data.setValue(coreDataATMResponse, forKey: "coreDataATM")
        
//        do {
//            try managedContext.save()
//            //coreDataATMResponse.append(data)
//        } catch let error as NSError {
//            print("save to coreData error \(error)")
//        }
    }
    
    func getFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataATM")
        
        do {
            coreDataATMResponse = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
        for dev in coreDataATMResponse {
            dataATMResponse.devices.append(DataATM(type: dev.value(forKey: "type") as! String,
                                                   cityRU: dev.value(forKey: "cityRU") as! String,
                                                   cityUA: dev.value(forKey: "cityUA") as! String,
                                                   cityEN: dev.value(forKey: "cityEN") as! String,
                                                   fullAddressRu: dev.value(forKey: "fullAddressRu") as! String,
                                                   fullAddressUa: dev.value(forKey: "fullAddressUa") as! String,
                                                   fullAddressEn: dev.value(forKey: "fullAddressEn") as! String,
                                                   placeRu: dev.value(forKey: "placeRu") as! String,
                                                   placeUa: dev.value(forKey: "placeUa") as! String,
                                                   latitude: dev.value(forKey: "latitude") as! String,
                                                   longitude: dev.value(forKey: "longitude") as! String))
        }
    }
    
    func deleteAllData(entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
                
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
        
    }
    
    
    ///////////////////////////////////////////////////////////////////////
    
    func saveToDataOfArray(data: Data) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CoreDataATMAsArray", in: managedContext)!
        let dataAsArray = NSManagedObject(entity: entity, insertInto: managedContext)
        
        
        dataAsArray.setValue(data, forKey: "dataOfArray")
        do {
            try managedContext.save()
            coreDataOfArray.append(dataAsArray)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func convertDataToStruct() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataATMAsArray")
        
        do {
            let results = try managedContext.fetch(fetchRequest) as AnyObject as! Array<Any>
            print(results)
            if results.count != 0 {
                for res in results {
                    //let d = res.value
                    print(res)
                }
                //self.convertDataToDataATM(data: result as! Data)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func convertDataToDataATM(data: Data) -> DataATMResponse {
        do {
            let parsedResult = try JSONDecoder().decode(DataATMResponse.self, from: data)
            return parsedResult
        } catch {
            print("JSONDecoder failuer")
        }
        return DataATMResponse()
    }
    
    
}
