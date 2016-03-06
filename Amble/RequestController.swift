//
//  RequestController.swift
//  Amble
//
//  Created by Matt O'Hagan on 3/5/16.
//  Copyright © 2016 Dream Team. All rights reserved.
//

import Foundation
import Alamofire


class ServerRequests {
    
    func createUser(username: String){
        let urlPath: String = "http://d5c866b1.ngrok.io/newUser"
        
        let nameofuser = ["username": username] as Dictionary<String, String>
        let theUrl: NSURL = NSURL(string: urlPath)!
        
        let request = NSMutableURLRequest(URL: theUrl)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(nameofuser, options: [])
        
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .Failure(let error):
                    print(error)
                case .Success(let responseObject):
                    
                    print(responseObject)
                }
        }
        
    }
}