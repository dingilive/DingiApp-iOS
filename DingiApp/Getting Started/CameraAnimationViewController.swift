//
//  CameraAnimationViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class CameraAnimationViewController: UIViewController, DingiMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = DingiMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.styleURL = DingiStyle.englishStyleURL
        let center = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        mapView.setCenter(center, zoomLevel: 7, direction: 0, animated: false)
        view.addSubview(mapView)

    }
    

    func mapViewDidFinishLoadingMap(_ mapView: DingiMapView) {
        
        let camera = DingiMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 4500, pitch: 15, heading: 180)
        mapView.setCamera(camera, withDuration: 5, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))

    }

}
