//
//  DDStudent+CoreDataClass.swift
//  
//
//  Created by Duba on 02.07.2018.
//
//

import Foundation
import CoreData


public class DDStudent: DDAbstract {
    static public let typeName = "DDStudent"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDStudent.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
