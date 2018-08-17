//
//  DDSubject+CoreDataProperties.swift
//  
//
//  Created by Duba on 02.07.2018.
//
//

import Foundation
import CoreData


extension DDSubject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDSubject> {
        return NSFetchRequest<DDSubject>(entityName: "DDSubject")
    }

    @NSManaged public var name: String?
    @NSManaged public var groupe: NSSet?
    @NSManaged public var student: NSSet?
    @NSManaged public var teacher: NSSet?
    @NSManaged public var mark: NSSet?

}

// MARK: Generated accessors for groupe
extension DDSubject {

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
extension DDSubject {

    @objc(addStudentObject:)
    @NSManaged public func addToStudent(_ value: DDStudent)

    @objc(removeStudentObject:)
    @NSManaged public func removeFromStudent(_ value: DDStudent)

    @objc(addStudent:)
    @NSManaged public func addToStudent(_ values: NSSet)

    @objc(removeStudent:)
    @NSManaged public func removeFromStudent(_ values: NSSet)

}

// MARK: Generated accessors for teacher
extension DDSubject {

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
extension DDSubject {

    @objc(addMarkObject:)
    @NSManaged public func addToMark(_ value: DDMark)

    @objc(removeMarkObject:)
    @NSManaged public func removeFromMark(_ value: DDMark)

    @objc(addMark:)
    @NSManaged public func addToMark(_ values: NSSet)

    @objc(removeMark:)
    @NSManaged public func removeFromMark(_ values: NSSet)

}
