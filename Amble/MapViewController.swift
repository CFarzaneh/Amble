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
    @IBOutlet weak var webView: UIWebView!
    
    var locationManager: CLLocationManager!
    var tripPoints = Array<Dictionary<String, String>>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("welcomeViewController") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        let url = NSURL (string: "http://d5c866b1.ngrok.io/map")
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
        
    }
    
    
    
    
    @IBAction func javascriptButton(sender: AnyObject) {
        let result = webView.stringByEvaluatingJavaScriptFromString("alert(\"Hello! I am an alert box!!\");")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var pastLat = 0.0
    var pastLon = 0.0
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //var locationArray = locations as NSArray
        for location in locations{
            var coord = location.coordinate
            
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            
            pastLat = abs(pastLat)
            pastLon = abs(pastLon)
            coord.latitude = abs(coord.latitude)
            coord.longitude = abs(coord.longitude)
            
            var latDiff = (coord.latitude - pastLat) * 10000
            var lonDiff = (coord.longitude - pastLon) * 10000
            
            print(latDiff)
            print(lonDiff)
            //            print(abs(coord.latitude) - abs(pastLat))
            //            print(abs(coord.longitude) - abs(pastLon))
            print("-----")
            
            pastLat = coord.latitude
            pastLon = coord.longitude
            
            
            
            let coordinate = ["lat": "\(coord.latitude)", "lon": "\(coord.longitude)"] as Dictionary<String, String>
            tripPoints.append(coordinate)
        }
    }
    
    // called from ViewController on completion of Twitter auth
    func startTracking(){
        
        var username = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String
        if let unwrapped = username {
            print(unwrapped)
        }
        
        if(CLLocationManager.locationServicesEnabled()){
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
            
        }
        
    }

}
