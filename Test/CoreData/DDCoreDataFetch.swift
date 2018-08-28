//
//  CoreDataFetch.swift
//  CoreDataTest
//
//  Created by Duba on 25.06.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON
class DDCoreDataFetch {
    
    
    
    
    //MARK:- DDStudent Request
    static func requestAllStudents() -> [DDCDStudent]? {
        var students = [DDCDStudent]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDSubject.typeName)
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
                
                students =  result as! [NSManagedObject] as! [DDCDStudent]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return students.count > 0 ? students : nil
        
    }
    
    static func enterStudentWith(instagramID: String) -> DDCDStudent? {
        var student = [DDCDStudent]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDCDStudent.typeName)
        let fetchPredicate = NSPredicate(format: "instagramID contains %@", instagramID)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            student = result as! [NSManagedObject] as! [DDCDStudent]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        return student.count > 0 ? student[0] : nil
        
    }
    
    static func enterStudentWith(facebookEmail: String) -> DDCDStudent? {
        var student = [DDCDStudent]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDCDStudent.typeName)
        let fetchPredicate = NSPredicate(format: "facebookEmail contains %@", facebookEmail)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            student = result as! [NSManagedObject] as! [DDCDStudent]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
        return student.count > 0 ? student[0] : nil
    }
    
    static func requestStudentFor(firstName: String, lastName : String) -> DDCDStudent? {
        var student = [DDCDStudent]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDCDStudent.typeName)
        let fetchPredicate = NSPredicate(format: "(firstName contains [cd] %@) AND (lastName contains [cd] %@)", firstName,lastName)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            student = result as! [NSManagedObject] as! [DDCDStudent]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
        
        return student.count > 0 ? student[0] : nil
    }
    
    static func enterStudentWith(login: String, password : String) -> DDCDStudent? {
        var student = [DDCDStudent]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDCDStudent.typeName)
        let fetchPredicate = NSPredicate(format: "(login == %@) AND (password == %@)", login,password)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            student = result as! [NSManagedObject] as! [DDCDStudent]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
        
        return student.count > 0 ? student[0] : nil
    }
    
    static func requestStudentsByGroupe(groupe: String)->[DDCDStudent]? {
        var student = [DDCDStudent]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDCDStudent.typeName)
        let fetchPredicate = NSPredicate(format: "groupe.name contains [cd] %@",groupe)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            student = result as! [NSManagedObject] as! [DDCDStudent]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
        
        return student
        
    }
    
    static func requestStudentPhoto(photo : NSData) -> NSData? {
        
        var student = [DDCDStudent]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDCDStudent.typeName)
        let fetchPredicate = NSPredicate(format: "photo == %@", photo)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            student = result as! [NSManagedObject] as! [DDCDStudent]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
        
        return student[0].photo
    }
    
    static func requestAverageMarkByStudent(student : DDCDStudent) -> Float? {
        
    
        let mark = student.mark
        let predic = mark.map {
            NSPredicate(format: "SELF IN %@",$0)
        }
        
        
        // Create fetch Request
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName:DDMark.typeName)
        
        // Set result format fo request
        fetchRequest.resultType = .dictionaryResultType
        
        // Create NSPredicate for find average number
   
        
        
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predic!])
        
        // Find property in object DDSubject
        let marksExpression = NSExpression(forKeyPath: "mark")
        
        
        let expressionDescription = NSExpression(forFunction: "average:", arguments: [marksExpression])
        let description = NSExpressionDescription()
        description.name = "averageMark"
        description.expression = expressionDescription
        description.expressionResultType = .floatAttributeType
        // Set NSExpression for request
        fetchRequest.propertiesToFetch = [description]
        fetchRequest.predicate = predicate
        var answerByDictionary = [[String:Any]]()
        do {
            if  let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest) as? [[String:Any]] {
                //Find result
                answerByDictionary = result
            }
            
        }
            
        catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
        
        // Get answer by dictionary
        var averageMark : Float!
        for obj in answerByDictionary {
            
            guard let answer = obj["averageMark"] as? NSNumber else {
                break
            }
            averageMark = answer.floatValue
            
        }
        
        return averageMark
    }
    
    
    //MARK:- Request DDTeacher
    static func enterTeacherWith(instagramID: String) -> DDTeacher? {
        var teacher = [DDTeacher]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDTeacher.typeName)
        let fetchPredicate = NSPredicate(format: "instagramID contains %@", instagramID)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
             teacher = result as! [NSManagedObject] as! [DDTeacher]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
       return teacher.count > 0 ? teacher[0] : nil
    }
    
    
    static func enterTeacherWith(facebookEmail: String) -> DDTeacher? {
        var teacher = [DDTeacher]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDTeacher.typeName)
        let fetchPredicate = NSPredicate(format: "email contains %@",facebookEmail)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            teacher = result as! [NSManagedObject] as! [DDTeacher]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        return teacher.count > 0 ? teacher[0] : nil
    }
    //MARK:- Request DDSubject
   static func loadSubjectForGroupe(name : String) -> [DDSubject] {
        var arraySubject = [DDSubject]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDSubject.typeName)
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        let fetchPredicate = NSPredicate(format: "groupe.name contains %@", name)
        fetchRequest.predicate = fetchPredicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
                
                arraySubject =  result as! [NSManagedObject] as! [DDSubject]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

        return arraySubject
        
    }
    
    static func requestSubjectMark(forSubject : DDSubject, forStudent: DDCDStudent) -> [DDMark]?{
        
        let mark : [DDMark]!
        
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDMark.typeName)
        let fetchPredicate = NSPredicate(format: "student = %@ AND (subject = %@) ", forStudent,forSubject)
        fetchRequest.predicate = fetchPredicate
        
        do {
            
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            mark = result as? [NSManagedObject] as! [DDMark]
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
        return mark
        
    }


  
    
   
    
    
    
    //MARK:- Request DDGroupe
    
    static func requestAllGroupes() -> [DDGroupe]{
        var groupes = [DDGroupe]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDGroupe.typeName)
   
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
               
                    groupes = result as! [NSManagedObject] as! [DDGroupe]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return groupes
    }
    
    static func requestGroupesBy(name : String) -> DDGroupe? {
        var groupes = [DDGroupe]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDGroupe.typeName)
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchPredicate = NSPredicate(format: "name = %@ ", name)
        fetchRequest.predicate = fetchPredicate
        
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
                
                groupes = result as! [NSManagedObject] as! [DDGroupe]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return groupes.count > 0 ? groupes[0] : nil
    }
   static func requestJournal(forGroupe groupe : DDGroupe, andDate date : Date) -> [DDJournal]{
        var journals = [DDJournal]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDJournal.typeName)
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let calendar = NSCalendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
    
    let predicate = NSPredicate(format: "(date >= %@) AND (date < %@) AND groupeName contains [cd] %@", startDate as CVarArg, endDate! as CVarArg, groupe.name!);
        fetchRequest.predicate = predicate
        
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
                
                journals = result as! [NSManagedObject] as! [DDJournal]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return journals
    }
    
    static func requestHousing(byLatitude : Double, andLongitude : Double) -> DDHousing? {
        var housing = [DDHousing]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDHousing.typeName)
        
        let fetchPredicate = NSPredicate(format: "latitude = %@ AND longitude = %@", byLatitude, andLongitude)
        fetchRequest.predicate = fetchPredicate
        
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
                
                housing = result as! [NSManagedObject] as! [DDHousing]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return housing.count > 0 ? housing[0] : nil
    }
    static func requestAllJournals() -> [DDJournal]? {
        var journals = [DDJournal]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: DDJournal.typeName)
        
       
        
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
                
                journals = result as! [NSManagedObject] as! [DDJournal]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return journals
    }
    
    
   
    
    
    
}
