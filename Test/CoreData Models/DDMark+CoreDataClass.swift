//
//  DDMark+CoreDataClass.swift
//  
//
//  Created by Duba on 02.07.2018.
//
//

import Foundation
import CoreData


public class DDMark: NSManagedObject {
    static public let typeName = "DDMark"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDMark.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
