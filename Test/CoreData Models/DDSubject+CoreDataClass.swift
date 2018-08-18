//
//  DDSubject+CoreDataClass.swift
//  
//
//  Created by Duba on 02.07.2018.
//
//

import Foundation
import CoreData


public class DDSubject: DDAbstract {
    static public let typeName = "DDSubject"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDSubject.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
