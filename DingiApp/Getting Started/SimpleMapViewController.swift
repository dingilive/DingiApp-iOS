//
//  SimpleMapViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap
import CoreLocation

class SimpleMapViewController: UIViewController, CLLocationManagerDelegate, DingiMapViewDelegate {
    
    let locationMgr = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()

        locationMgr.delegate = self
        locationMgr.startUpdatingLocation()
        
        let mapView = DingiMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078), zoomLevel: 13, animated: false)
        view.addSubview(mapView)
        
        let status  = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationMgr.requestWhenInUseAuthorization()
            return
        }
    }

    
    

    func mapViewDidFinishLoadingMap(_ mapView: DingiMapView) {
        print("qwerty")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        print("Current location: \(currentLocation)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
