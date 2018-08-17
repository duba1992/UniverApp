//
//  DDFirebaseRequest.swift
//  CoreDataTest
//
//  Created by Duba on 05.08.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import Firebase

class DDFirebaseRequest {
    
    static public func enterStudentWith(email: String, completion: @escaping (DDFBStudent) -> ()) {
       
        let db = Firestore.firestore()
    
        db.collection(DDStudentFirebase.studentCollection).whereField(DDStudentFirebase.facebookEmail, isEqualTo: email).getDocuments { (querySnap, error) in
            if error != nil {
                print("Error!!!")
            }
            print(email)
            
            for document in querySnap!.documents {
                print("\(document.documentID) => \(document.data())")
                let ddUser = DDFBStudent(JSON: document.data())
                ddUser?.firebaseID = document.documentID
                db.collection(DDStudentFirebase.studentCollection).document(document.documentID).collection(DDMarkFirebase.marksCollection).getDocuments(completion: { (query, err) in
                    if err != nil {
                        return
                    }
                    for doc in query!.documents {
                        let mark = DDFBMark(JSON: doc.data())
                        ddUser?.marks.append(mark!)
                    }
                    if let ddUser = ddUser {
                        completion(ddUser)
                    }
                })

            }
        }
    }
    
    
}
