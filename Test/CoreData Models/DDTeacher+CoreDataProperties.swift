//
//  DDTeacher+CoreDataProperties.swift
//  
//
//  Created by Duba on 29.06.2018.
//
//

import Foundation
import CoreData


extension DDTeacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDTeacher> {
        return NSFetchRequest<DDTeacher>(entityName: "DDTeacher")
    }

    @NSManaged public var dateOfbirth: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var instagramID: String?
    @NSManaged public var groupe: NSSet?
    @NSManaged public var student: NSSet?
    @NSManaged public var subject: NSSet?

}

// MARK: Generated accessors for groupe
extension DDTeacher {

    @objc(addGroupeObject:)
    @NSManaged public func addToGroupe(_ value: DDGroupe)

    @objc(removeGroupeObject:)
    @NSManaged public func removeFromGroupe(_ value: DDGroupe)

    @objc(addGroupe:)
    @NSManaged public func addToGroupe(_ values: NSSet)

    @objc(removeGroupe:)
    @NSManaged public func removeFromGroupe(_ values: NSSet)

}

// MARK: Generated accessors for student
extension DDTeacher {

    @objc(addStudentObject:)
    @NSManaged public func addToStudent(_ value: DDCDStudent)

    @objc(removeStudentObject:)
    @NSManaged public func removeFromStudent(_ value: DDCDStudent)

    @objc(addStudent:)
    @NSManaged public func addToStudent(_ values: NSSet)

    @objc(removeStudent:)
    @NSManaged public func removeFromStudent(_ values: NSSet)

}

// MARK: Generated accessors for subject
extension DDTeacher {

    @objc(addSubjectObject:)
    @NSManaged public func addToSubject(_ value: DDSubject)

    @objc(removeSubjectObject:)
    @NSManaged public func removeFromSubject(_ value: DDSubject)

    @objc(addSubject:)
    @NSManaged public func addToSubject(_ values: NSSet)

    @objc(removeSubject:)
    @NSManaged public func removeFromSubject(_ values: NSSet)

}
