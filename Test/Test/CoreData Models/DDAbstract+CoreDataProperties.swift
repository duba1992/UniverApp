//
//  DDAbstract+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Duba on 11.05.2018.
//  Copyright © 2018 Duba. All rights reserved.
//
//

import Foundation
import CoreData


extension DDAbstract {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDAbstract> {
        return NSFetchRequest<DDAbstract>(entityName: "DDAbstract")
    }


}
