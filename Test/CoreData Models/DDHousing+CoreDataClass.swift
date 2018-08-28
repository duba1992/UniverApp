//
//  DDHousing+CoreDataClass.swift
//  
//
//  Created by Duba on 26.08.2018.
//
//

import Foundation
import CoreData


public class DDHousing: DDAbstract {
    static public let typeName = "DDHousing"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDHousing.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
