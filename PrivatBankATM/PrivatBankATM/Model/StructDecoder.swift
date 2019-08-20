//
//  StructDecoder.swift
//  PrivatBankATM
//
//  Created by Serhii CHORNONOH on 8/19/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import Foundation
import CoreData

protocol StructDecoder {
    
    static var CoreDataATMResponse : String { get }
    
    func toCoreData(context: NSManagedObjectContext) throws -> NSManagedObject
}

enum SerializationError: Error {
    case structRequired
    case unlnownEntity(name: String)
    case unsupportedSubType(label: String?)
}

extension StructDecoder {
    func toCoreData(context: NSManagedObjectContext) throws -> NSManagedObject {
        
        let entityName = type(of: self).CoreDataATMResponse
        
        guard let desc = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("unknowneEntity"); return NSManagedObject()//throw unknowneEntity(name: entityName)
        }
        let managedObject = NSManagedObject(entity: desc, insertInto: context)
        
        let mirror = Mirror(reflecting: self)
        
        guard mirror.displayStyle == .struct else {
            throw SerializationError.structRequired
        }
        print("StructDecoder")
        return managedObject
    }
}
