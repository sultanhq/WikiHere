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
    
    var latDegrees: Double = 0.0
    var longDegrees: Double = 0.0
    
    var Location: String? {
        didSet {
            guard let checkedLocation = Location else {
                print ("no Location")
                return
            }
            locationLabel.text = checkedLocation
            getJSON()
            
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed us to access location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Requested location update")
        let userLocation:CLLocation = locations[0] as CLLocation
            latDegrees = userLocation.coordinate.latitude
            longDegrees = userLocation.coordinate.longitude
            Location = ("Lat: \(userLocation.coordinate.latitude) \n Lon: \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Requested location update but failed getting location \(error)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func tappedButton(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            Location = "Getting Location..."
        }
    
    
    }
    
    func getJSON() {
        
    let myUrl = URL(string: "https://en.wikipedia.org/w/api.php");
    
    var request = URLRequest(url:myUrl!)
       
    request.httpMethod = "POST"// Compose a query string
    
    let postString = "action=query&list=geosearch&gscoord=\(latDegrees)%7C\(longDegrees)&gsradius=10000&gslimit=10&format=json";
    
    request.httpBody = postString.data(using: String.Encoding.utf8);
    
    let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        
        if error != nil
        {
            print("error=\(error)")
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            
            if let parseJSON = json {
                
                let queryString = parseJSON["query"] as? NSDictionary
                
                if let resultDict = queryString?["geosearch"] as? NSArray {
                    
                    let firstItem = resultDict[0] as? NSDictionary
                    
                    let pageid = (firstItem!["pageid"] as? Int)!
                    if pageid != 40678171 {
                        let wikiUrl = "http://en.wikipedia.org/?curid=\(pageid)"
                        print("WikiUrl = \(wikiUrl)")
                        
                        self.open(scheme: wikiUrl)
                        
                    }

                }

                
                
                

            }
        } catch {
            print(error)
        }
    }
    task.resume()
    
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
}
