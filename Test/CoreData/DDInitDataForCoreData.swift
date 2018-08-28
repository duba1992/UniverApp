//
//  DDInitDataForCoreData.swift
//  CoreDataTest
//
//  Created by Duba on 04.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import UIKit


class DDInitDataForCoreData {
    
    public func saveMyStudent() {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        let birthDay = dateFormatterGet.date(from: "06-08-1992")
        var myStudent = DDCDStudent()
        myStudent.firstName = "Dmitrij"
        myStudent.lastName = "Dubin"
        myStudent.facebookEmail = "dmytrodmytro19@gmail.com"
        myStudent.instagramID = "8102226021"
        myStudent.firebaseID = "hn4EWduTAjjsXlDwiHwr"
        let groupe = DDCoreDataFetch.requestGroupesBy(name: "Programming")
        myStudent.groupe = groupe
        let image = UIImage(named: "me.jpg")
        let imageData : NSData = UIImagePNGRepresentation(image!)! as NSData
        myStudent.photo = imageData
     
        myStudent.dateOfBirth = birthDay as NSDate?
        myStudent.addToSubject((myStudent.groupe?.subject)!)
        setRandomMarksForStudent(student: &myStudent, groupe: myStudent.groupe!)
        myStudent.password = "Dubin"
        myStudent.login = "Dmitrij"
        DDCoreDataManager.instance.saveContext()
        
    }
    
    public func saveNewGroupsWithSubjects()  {
        let namePhylologySubject = ["Foreign language","Physical Culture", "National history", "Pedagogy and Psychology", "Philosophy", "Foreign language for professional communication", "Aesthetics of the text", "Linguoculture", "Logic", "Sociology", "Jurisprudence", "Political science", "Fundamentals of speech communication", "Sociolinguistics"]
        let namePhylosofySubject = ["Logic", "History and theory of world culture", "Ontology and theories of knowledge", "Social Philosophy and Philosophy of History", "Philosophy and Methodology of Science", "Ethics", "Aesthetics", "History of Ukrainian Philosophy", "History of foreign philosophy", "Philosophy of Religion and Religious Studies", "Philosophical Anthropology", "Philosophy of politics and law", "Philosophy of Language and Communication", "Philosophy of Education"]
        let nameDevelopment = ["C", "C++", "Java","Javascript", "SQL", "Objective C", "HTML", "Swift", "C#", "Ruby", "PHP"]
        let nameGroups = ["Philology","Philosophy","Programming"]
        
        var subjects = [DDSubject]()
        for i in 0..<namePhylologySubject.count{
            let subject = DDSubject()
            subject.name = namePhylologySubject[i]
            subjects.append(subject)
        }
        
        
        var group = DDGroupe()
        group.name = nameGroups[0]
        for i in 0..<subjects.count {
            group.addToSubject(subjects[i])
            
        }
        var building = initHousing(name: "Main Housing", latitude: 46.987508, longitude: 32.001310)
        randomInitJournal(forGroupe: group, inHousing: building, andSubject: subjects)
        DDCoreDataManager.instance.saveContext()
        
        
        group = DDGroupe()
        subjects = [DDSubject]()
        for i in 0..<namePhylosofySubject.count{
            let subject = DDSubject()
            subject.name = namePhylosofySubject[i]
            subjects.append(subject)
        }
        group.name = nameGroups[1]
        for i in 0..<subjects.count {
            group.addToSubject(subjects[i])
            
        }
        building = initHousing(name: "Old Housing", latitude: 46.953670, longitude: 31.987597)
        randomInitJournal(forGroupe: group, inHousing: building, andSubject: subjects)
        DDCoreDataManager.instance.saveContext()
        group = DDGroupe()
        subjects = [DDSubject]()
        for i in 0..<nameDevelopment.count{
            let subject = DDSubject()
            subject.name = nameDevelopment[i]
            subjects.append(subject)
        }
        group.name = nameGroups[2]
        for i in 0..<subjects.count {
            group.addToSubject(subjects[i])
            
        }
        building = initHousing(name: "New Housing", latitude: 46.968307, longitude: 31.960532)
        randomInitJournal(forGroupe: group, inHousing: building, andSubject: subjects)
        DDCoreDataManager.instance.saveContext()
        
    }
    
    
    public func saveNewRandomStudents() {
        var students = [DDCDStudent]()
        
        let groupes = DDCoreDataFetch.requestAllGroupes()
        
        let studentFirstName = ["Christine","Alex","Bobby","Kate","Bob","Vladimir","Julya","Luke","Sullivan","Lidia","Kenzo","Roy", "Mila","Mykie", "Myles", "Antonina", "Nabeel","Sandy", "Sanfur", "Sanjay", "Santiago", "Marine", "Satveer","Olivier", "Helena", "Chalm", "Peter", "Mirin", "Kirill", "Viktor" ]
        
        
        
        let studentLastName = ["Carson", "Davis", "Duffy", "Dudley", "Greene", "Hogan", "Morales", "Henry", "Young", "Pugh", "Lopez", "Harvey", "Franklin", "Patel", "Blake", "Levy", "Whitfield", "Acosta", "Evans", "Fisher", "Hyde", "Oneill", "West", "Peterson", "Finlis", "Burberry", "Merigan", "Hayward", "Solikan", "Nolimus"]
        
        for i in 0..<studentFirstName.count {
            var student = DDCDStudent()
            student.firstName = studentFirstName[i]
            student.lastName = studentLastName[i]
            
            student.groupe = groupes[i/10]
            student.addToSubject(groupes[i/10].subject!)

            let image = UIImage(named: "\(i).jpg")
            let imageData : NSData = UIImagePNGRepresentation(image!)! as NSData
            student.photo = imageData
            student.addToSubject((student.groupe?.subject)!)
            student.login = "login\(i)"
            student.password = "password\(i)"
            
            
            setRandomMarksForStudent(student: &student, groupe: student.groupe!)
            
            
            
            students.append(student)
        }
        DDCoreDataManager.instance.saveContext()
        
    }
    func setRandomMarksForStudent( student : inout  DDCDStudent, groupe: DDGroupe) {
        
        for _ in 0..<50{
            
            
            
            
            guard let object = student.subject?.allObjects as? [DDSubject] else {
                return
            }
            let random = arc4random_uniform(UInt32(object.count))
            let sub = object[Int(random)]
            
            let mark = DDMark()
            
            let numberMark = arc4random_uniform(12 - 5) + 5;
            
            mark.mark = Int16(UInt16(numberMark))
            let day = arc4random_uniform(28 - 1) + 1
            let month = arc4random_uniform(12 - 1) + 1
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyyy"
            let  date = dateFormatterGet.date(from: "\(day)-\(month)-2018")
            mark.date = date as NSDate?as NSDate?
            
            mark.subject = sub
            
            student.addToMark(mark)
            
            
        }
        
    }
    func initHousing(name : String, latitude : Double, longitude : Double) -> DDHousing {
        let building = DDHousing()
        building.name = name
        building.latitude = latitude
        building.longitude = longitude
        return building
    }
    func randomInitJournal(forGroupe : DDGroupe, inHousing : DDHousing, andSubject subject : [DDSubject])  {
        
        var journals = [DDJournal]()
        for _ in 0..<50 {
        
            let day = arc4random_uniform(28 - 1) + 1
            let month = arc4random_uniform(12 - 1) + 1
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyyy HH:mm"
            dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
            var startTimeHour = 9
            var startTimeMinute = 0
           
            for _ in 0..<5 {
                let journal = DDJournal()
                journal.date =  dateFormatterGet.date(from: "\(day)-\(month)-2018 \(startTimeHour):\(startTimeMinute)")! as NSDate
                let random = arc4random_uniform(UInt32(subject.count))
                journal.subject = subject[Int(random)].name;
                journal.longitude = inHousing.longitude
                journal.latitude = inHousing.latitude
                journal.lectureHall = Int16(arc4random_uniform(500))
                journal.groupeName = forGroupe.name
                
                
                startTimeHour = startTimeHour + 1
                startTimeMinute = startTimeMinute + 30
                if startTimeMinute > 59 {
                    startTimeMinute = 1
                    startTimeHour = startTimeHour + 1
                }
                journals.append(journal)
                forGroupe.addToJournal(journal)
                
            }
        
        }
        
        
    }
    
   
    
}
