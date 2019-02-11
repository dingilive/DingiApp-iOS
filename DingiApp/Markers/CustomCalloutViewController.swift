//
//  CustomCalloutViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 10/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class CustomCalloutViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = DingiMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        mapView.delegate = self
        let center = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        mapView.setCenter(center, zoomLevel: 14, animated: false)
//        addAnnotation()
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: DingiMapView) {
        addAnnotation()
    }
    
    
    func addAnnotation() {
        let annotation = DingiPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        annotation.title = "Testing Place"
        annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    func mapView(_ mapView: DingiMapView, annotationCanShowCallout annotation: DingiAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: DingiMapView, leftCalloutAccessoryViewFor annotation: DingiAnnotation) -> UIView? {
        if (annotation.title! == "Testing Place") {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
            label.textAlignment = .right
            label.textColor = UIColor(red: 0.81, green: 0.71, blue: 0.23, alpha: 1)
            label.text = "Sample"
            return label
        }
        
        return nil
    }
    
    func mapView(_ mapView: DingiMapView, rightCalloutAccessoryViewFor annotation: DingiAnnotation) -> UIView? {
        return UIButton(type: .detailDisclosure)
    }
    
    func mapView(_ mapView: DingiMapView, annotation: DingiAnnotation, calloutAccessoryControlTapped control: UIControl) {
        // Hide the callout view.
        mapView.deselectAnnotation(annotation, animated: false)
        let alert = UIAlertController(title: annotation.title!!, message: "A lovely (if touristy) place.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
