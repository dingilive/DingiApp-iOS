//
//  MarkerOnTapViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class MarkerOnTapViewController: UIViewController {
    
    var mapView: DingiMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = DingiMapView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), styleURL: DingiStyle.englishStyleURL)
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let center = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        mapView.setCenter(center, zoomLevel: 14, animated: false)
        view.addSubview(mapView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(singleTap)


    }
    
    
    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        let spot = sender.location(in: mapView)
        let coord = mapView.convert(spot, toCoordinateFrom: mapView)
        let hello = DingiPointAnnotation()
        hello.coordinate = coord
        mapView.addAnnotation(hello)
    }

}
