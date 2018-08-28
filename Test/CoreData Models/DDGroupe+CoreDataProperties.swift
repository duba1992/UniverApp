//
//  DDGroupe+CoreDataProperties.swift
//  
//
//  Created by Duba on 26.08.2018.
//
//

import Foundation
import CoreData


extension DDGroupe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DDGroupe> {
        return NSFetchRequest<DDGroupe>(entityName: "DDGroupe")
    }

    @NSManaged public var name: String?
    @NSManaged public var student: NSSet?
    @NSManaged public var subject: NSSet?
    @NSManaged public var teacher: NSSet?
    @NSManaged public var journal: NSSet?

}

// MARK: Generated accessors for student
extension DDGroupe {

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
extension DDGroupe {

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
extension DDGroupe {

    @objc(addTeacherObject:)
    @NSManaged public func addToTeacher(_ value: DDTeacher)

    @objc(removeTeacherObject:)
    @NSManaged public func removeFromTeacher(_ value: DDTeacher)

    @objc(addTeacher:)
    @NSManaged public func addToTeacher(_ values: NSSet)

    @objc(removeTeacher:)
    @NSManaged public func removeFromTeacher(_ values: NSSet)

}

// MARK: Generated accessors for journal
extension DDGroupe {

    @objc(addJournalObject:)
    @NSManaged public func addToJournal(_ value: DDJournal)

    @objc(removeJournalObject:)
    @NSManaged public func removeFromJournal(_ value: DDJournal)

    @objc(addJournal:)
    @NSManaged public func addToJournal(_ values: NSSet)

    @objc(removeJournal:)
    @NSManaged public func removeFromJournal(_ values: NSSet)

}
