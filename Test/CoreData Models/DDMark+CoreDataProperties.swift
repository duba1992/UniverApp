//
//  DDMark+CoreDataProperties.swift
//  
//
//  Created by Duba on 02.07.2018.
//
//

import Foundation
import CoreData


extension DDMark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDMark> {
        return NSFetchRequest<DDMark>(entityName: "DDMark")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var mark: Int16
    @NSManaged public var student: DDStudent?
    @NSManaged public var subject: DDSubject?

}
