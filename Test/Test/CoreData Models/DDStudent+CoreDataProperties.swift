//
//  DDStudent+CoreDataProperties.swift
//  
//
//  Created by Duba on 02.07.2018.
//
//

import Foundation
import CoreData


extension DDStudent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDStudent> {
        return NSFetchRequest<DDStudent>(entityName: "DDStudent")
    }

    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var instagramID: String?
    @NSManaged public var lastName: String?
    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var groupe: DDGroupe?
    @NSManaged public var subject: NSSet?
    @NSManaged public var teacher: NSSet?
    @NSManaged public var mark: NSSet?

}

// MARK: Generated accessors for subject
extension DDStudent {

    @objc(addSubjectObject:)
    @NSManaged public func addToSubject(_ value: DDSubject)

    @objc(removeSubjectObject:)
    @NSManaged public func removeFromSubject(_ value: DDSubject)

    @objc(addSubject:)
    @NSManaged public func addToSubject(_ values: NSSet)

    @objc(removeSubject:)
    @NSManaged public func removeFromSubject(_ values: NSSet)

}

// MARK: Generated accessors for teacher
extension DDStudent {

    @objc(addTeacherObject:)
    @NSManaged public func addToTeacher(_ value: DDTeacher)

    @objc(removeTeacherObject:)
    @NSManaged public func removeFromTeacher(_ value: DDTeacher)

    @objc(addTeacher:)
    @NSManaged public func addToTeacher(_ values: NSSet)

    @objc(removeTeacher:)
    @NSManaged public func removeFromTeacher(_ values: NSSet)

}

// MARK: Generated accessors for mark
extension DDStudent {

    @objc(addMarkObject:)
    @NSManaged public func addToMark(_ value: DDMark)

    @objc(removeMarkObject:)
    @NSManaged public func removeFromMark(_ value: DDMark)

    @objc(addMark:)
    @NSManaged public func addToMark(_ values: NSSet)

    @objc(removeMark:)
    @NSManaged public func removeFromMark(_ values: NSSet)

}
