//
//  DDCDStudent+CoreDataClass.swift
//  
//
//  Created by Duba on 17.08.2018.
//
//

import Foundation
import CoreData


public class DDCDStudent: DDAbstract {

        static public let typeName = "DDCDStudent"
        convenience init() {
            
            self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDCDStudent.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
        }

}
