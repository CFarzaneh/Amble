//
//  ViewController.swift
//  Amble
//
//  Created by Cameron Farzaneh on 3/5/16.
//  Copyright © 2016 Dream Team. All rights reserved.
//

import UIKit
import TwitterKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                let uersname = unwrappedSession.userName
                var nameofuser = ["username": uersname] as Dictionary<String, String>
    
                let urlPath: String = "http://d5c866b1.ngrok.io/newUser"
                var theUrl: NSURL = NSURL(string: urlPath)!
                
                let request = NSMutableURLRequest(URL: theUrl)
                request.HTTPMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let values = nameofuser
                
                request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(values, options: [])
                
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
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

