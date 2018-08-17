//
//  DDGroupe+CoreDataClass.swift
//  CoreDataTest
//
//  Created by Duba on 17.05.2018.
//  Copyright © 2018 Duba. All rights reserved.
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
