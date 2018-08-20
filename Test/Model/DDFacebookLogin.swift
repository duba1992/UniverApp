//
//  DDFacebookLogin.swift
//  CoreDataTest
//
//  Created by Duba on 05.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON
import Firebase
import FirebaseAuth
class DDFacebookLogin : DDStartViewController {
    
    public func FacebookEnterAndGet(completion: @escaping (DDFBStudent?)->(), failure : @escaping (String?)->()) {
        
       
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err) in
            
            if err != nil {
                print ("Facebook button error!!!!!!!!")
                failure("Error")
                return
            }
            if let result = result?.token {
                guard let accessToken = result.tokenString else {
                    return
                }
                
                
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"], tokenString: accessToken, version: nil, httpMethod: "GET").start(completionHandler: { (connection, res, error) in
                    
            
                    let json = JSON(res!)
                
                    let emailFacebook = json["email"].stringValue
                 
                    DDFirebaseRequest.enterStudentWith(email: emailFacebook, completion: { (ddUser) in
                        completion(ddUser)
                    })
                   
                  
                })

            } else {
                let error = "Error"
                failure(error)
            }
          
        }
     
       
    }
    
    func getFacebookEmail(completion : @escaping (String?) -> Void) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, err) in
            
            if err != nil {
                print ("Facebook button error!!!!!!!!")
                return
            }
            if let result = result?.token {
                guard let accessToken = result.tokenString else {
                    return
                }
                
                
                FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"], tokenString: accessToken, version: nil, httpMethod: "GET").start(completionHandler: { (connection, res, error) in
                    
                    
                    let json = JSON(res!)
                    
                    let emailFacebook = json["email"].stringValue
    
                    completion(emailFacebook)
                })
                
            }
        }
    }
}
    

    




