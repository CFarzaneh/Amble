//
//  RequestController.swift
//  Amble
//
//  Created by Matt O'Hagan on 3/5/16.
//  Copyright © 2016 Dream Team. All rights reserved.
//

import Foundation
import Alamofire


// all requests back and forth from the node server
class ServerRequests {
    
    let baseUrl: String = "http://d5c866b1.ngrok.io";
    
    // POST create a new user
    func createUser(username: String){
        let urlPath: String = baseUrl + "/newUser"
        
        
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
    
    // GET request an explore loop route
    func getExploreLoop(username: String){
        let urlPath: String = baseUrl + "/explore/loop"
        
        
        let nameofuser = ["username": username] as Dictionary<String, String>
        let theUrl: NSURL = NSURL(string: urlPath)!
        
        let request = NSMutableURLRequest(URL: theUrl)
        request.HTTPMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(nameofuser, options: [])
        
        Alamofire.request(request)
            .responseJSON { response in
                // do whatever you want here
                switch response.result {
                case .Failure(let error):
                    print(error)
                case .Success(let JSON):
                    
                    print("Explore loop success with JSON: \(JSON)")
                    
                    let response = JSON as! NSDictionary
                    
                    //example if there is an id
                    let userId = response.objectForKey("id")!
                    
                    
                    
                    // TODO:
                    
                    // show modal with info
                    // tell webview to ask for data of route loop
                    // but not show it yet
                    
                    
                }
        }
    }
    
    
    //--- javascript functions
    
    // pass username for initial load of map data
    
    // find a new route
    // get data to ios for modal
    // tell web view to ask server for the dope route, find a route
    // if user accepts ios modal, tell web view to show the route that it has ready
    
    // sending trip data
    // once a trip is done, send all of the points to /tracking to store in mongo
    
    // figure out current location
    
    
    
    
    
    
}