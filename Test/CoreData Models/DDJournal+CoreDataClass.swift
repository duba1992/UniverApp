//
//  DDJournal+CoreDataClass.swift
//  
//
//  Created by Duba on 26.08.2018.
//
//

import Foundation
import CoreData


public class DDJournal: DDAbstract {
    static public let typeName = "DDJournal"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDJournal.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
