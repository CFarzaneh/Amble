//
//  MapViewController.swift
//  Amble
//
//  Created by Cameron Farzaneh on 3/5/16.
//  Copyright © 2016 Dream Team. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let serverRequests = ServerRequests()
    
    @IBAction func exploreBtn(sender: UIBarButtonItem) {
        let username = "user" //ViewController.username
        serverRequests.getExploreLoop(username)
        print("explore button!")
        
    }
    
    @IBOutlet weak var textLabel: UITextView!
    var locationManager: CLLocationManager!
    var tripPoints = Array<Dictionary<String, String>>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("welcomeViewController") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // called from ViewController on completion of Twitter auth
    func startTracking(){
        if(CLLocationManager.locationServicesEnabled()){
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
            
        }
    }

}
