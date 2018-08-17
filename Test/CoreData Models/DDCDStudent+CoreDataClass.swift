//
//  DDCDStudent+CoreDataClass.swift
//  
//
//  Created by Duba on 05.08.2018.
//
//

import Foundation
import CoreData


public class DDCDStudent: DDAbstract {
    static public let typeName = "DDCDStudent"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: DDCDStudent.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}

extension DDCDStudent {
    func setStudent(_ student : DDCDStudent, withStudent : DDFBStudent) -> DDCDStudent {
        student.firstName = withStudent.firstName
        student.lastName = withStudent.lastName
        student.dateOfBirth = withStudent.birthDay! as? NSDate
        student.firebaseID = withStudent.firebaseID
        student.facebookEmail = withStudent.facebookEmail
        return student
    }
}
