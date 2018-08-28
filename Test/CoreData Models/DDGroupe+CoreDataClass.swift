//
//  DDGroupe+CoreDataClass.swift
//  
//
//  Created by Duba on 26.08.2018.
//
//

import Foundation
import CoreData


public class DDGroupe: DDAbstract {
    static public let typeName = "DDGroupe"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDGroupe.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
