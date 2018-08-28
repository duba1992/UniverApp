//
//  DDHousing+CoreDataProperties.swift
//  
//
//  Created by Duba on 26.08.2018.
//
//

import Foundation
import CoreData


extension DDHousing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDHousing> {
        return NSFetchRequest<DDHousing>(entityName: "DDHousing")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?

}
