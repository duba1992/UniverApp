//
//  DDTeacher+CoreDataClass.swift
//  
//
//  Created by Duba on 29.06.2018.
//
//

import Foundation
import CoreData


public class DDTeacher: DDAbstract {
    static public let typeName = "DDTeacher"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDTeacher.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
