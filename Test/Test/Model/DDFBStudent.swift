//
//  DDUser.swift
//  CoreDataTest
//
//  Created by Duba on 05.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import ObjectMapper

class DDFBMark : Mappable {
    
    var mark : Int?
    var date : Date?
    var subject : String?
    var teacherName : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        mark <- map["mark"]
        date <- map["date"]
        subject <- map["subject"]
        teacherName <- map["teacherName"]
        
    }
    
    
    
}

class DDFBStudent : Mappable {
   
    var firstName : String?
    var lastName : String?
    var facebookEmail : String?
    var birthDay : Date?
    var groupeName : Int?
    var marks = [DDFBMark]()
    var firebaseID : String?
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        facebookEmail <- map["facebookEmail"]
        birthDay <- map["birthDay"]
        groupeName <- map["groupeNumber"]
        
    }
    
    
}
