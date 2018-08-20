//
//  AlomofireRequest.swift
//  CoreDataTest
//
//  Created by Duba on 05.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class DDAlamofireRequest {
    
    
    static public func requestInstagramUser(_ accessToken : String, completion : @escaping (_ userID: String, _ error: Error?) -> Void) {
        if accessToken == "" {
            return
        }
      
        let string = "https://api.instagram.com/v1/users/self/?access_token=\(accessToken)"
        let url = URL(string: string)
        guard let urlRequest = url else {
            return
        }
        request(urlRequest).responseJSON { (res) in
            if res.result.isSuccess {
            var result = JSON(res.result.value!)
            let userID = result["data"]["id"].stringValue
          
            completion(userID, nil)
            } else {
                completion("error", res.error)
            }
    
            
            //https://api.instagram.com/v1/users/self/?access_token=8102226021.b71c42c.a43c44589f1e41fa909181d981b3ed41
        }
      
        
        
    }
    
    
}
