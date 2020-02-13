    //
//  ViewController.swift
//  Geolocation
//
//  Created by Eugene Tan on 2/12/20.
//  Copyright © 2020 Eugene Tan. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestAlwaysAuthorization()
        
        //locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
            print(location.speed)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled", message: "In order to find coordinates we need location.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

