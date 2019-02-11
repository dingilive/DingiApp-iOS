//
//  MarkerWithTextViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class MarkerWithTextViewController: UIViewController, DingiMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = DingiMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078), zoomLevel: 12, animated: false)
        view.addSubview(mapView)
        
        mapView.delegate = self

        let hello = DingiPointAnnotation()
        hello.coordinate = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        hello.title = "Hello world!"
        hello.subtitle = "Welcome to my marker"
        mapView.addAnnotation(hello)
    }
    
    
    func mapView(_ mapView: DingiMapView, viewFor annotation: DingiAnnotation) -> DingiAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: DingiMapView, annotationCanShowCallout annotation: DingiAnnotation) -> Bool {
        return true
    }
    



}
