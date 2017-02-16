//
//  ViewController.swift
//  WikiHere
//
//  Created by Rob Adams on 16/02/2017.
//  Copyright © 2017 Rob Adams. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    var gps: GPS?
    
    var Location: String? {
        didSet {
            guard let checkedLocation = Location else {
                print ("no Location")
                return
            }
            locationLabel.text = checkedLocation
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gps = GPS()
        guard let checkedGPS = gps else {
            print("GPS is nil")
            return
        }
        
        isAuthorizedtoGetUserLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    //if we have no permission to access user location, then ask user for permission.
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    //this method will be called each time when a user change his location access preference.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed us to access location")
            //do whatever init activities here.
        }
    }
    
    //this method is called by the framework on         locationManager.requestLocation();
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called")
        let userLocation:CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
        print(userLocation.coordinate)

        //store the user location here to firebase or somewhere
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func tappedButton(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            
        }
        Location = gps?.Location()
//        locationManager.userLo
    }
    
    func locationManager(manager: CLLocationManager!,   didUpdateLocations locations: [AnyObject]!) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
