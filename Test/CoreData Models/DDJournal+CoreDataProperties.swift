//
//  DDJournal+CoreDataProperties.swift
//  
//
//  Created by Duba on 26.08.2018.
//
//

import Foundation
import CoreData


extension DDJournal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDJournal> {
        return NSFetchRequest<DDJournal>(entityName: "DDJournal")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var groupeName: String?
    @NSManaged public var subject: String?
    @NSManaged public var teacherNumber: Int16
    @NSManaged public var lectureHall: Int16
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var groupes: NSSet?

}

// MARK: Generated accessors for groupes
extension DDJournal {

    @objc(addGroupesObject:)
    @NSManaged public func addToGroupes(_ value: DDGroupe)

    @objc(removeGroupesObject:)
    @NSManaged public func removeFromGroupes(_ value: DDGroupe)

    @objc(addGroupes:)
    @NSManaged public func addToGroupes(_ values: NSSet)

    @objc(removeGroupes:)
    @NSManaged public func removeFromGroupes(_ values: NSSet)

}
