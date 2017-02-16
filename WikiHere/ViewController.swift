//
//  ViewController.swift
//  WikiHere
//
//  Created by Rob Adams on 16/02/2017.
//  Copyright © 2017 Rob Adams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func tappedButton(_ sender: UIButton) {
        Location = gps?.Location()
    }

}

