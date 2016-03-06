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
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var tripPoints = Array<Dictionary<String, String>>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                
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
                
                if(CLLocationManager.locationServicesEnabled()){
                    self.locationManager = CLLocationManager()
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.requestAlwaysAuthorization()
                    self.locationManager.startUpdatingLocation()
                    
                }
                
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //var locationArray = locations as NSArray
        for location in locations{
            let coord = location.coordinate
            print(coord.latitude)
            print(coord.longitude)
            
            let coordinate = ["lat": "\(coord.latitude)", "lon": "\(coord.longitude)"] as Dictionary<String, String>
            tripPoints.append(coordinate)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

