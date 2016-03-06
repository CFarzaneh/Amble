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

    let serverRequests = ServerRequests();
    let mapViewController = MapViewController();
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                
                self.username = unwrappedSession.userName
                self.serverRequests.createUser(self.username)
                
                self.dismissViewControllerAnimated(true, completion: self.mapViewController.startTracking)
                
                
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

