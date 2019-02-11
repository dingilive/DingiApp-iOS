//
//  CustomMarkerViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class MyCustomPointAnnotation: DingiPointAnnotation {
    var willUseImage: Bool = false
}

class CustomMarkerViewController: UIViewController, DingiMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = DingiMapView(frame: view.bounds, styleURL: DingiStyle.englishStyleURL)
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: 23.746421, longitude: 90.3856996), zoomLevel: 15, animated: false)
        view.addSubview(mapView)
        mapView.delegate = self
        
        // Create four new point annotations with specified coordinates and titles.
        let pointA = MyCustomPointAnnotation()
        pointA.coordinate = CLLocationCoordinate2D(latitude: 23.746421, longitude: 90.3856996)
        pointA.title = "Green Life Hospital & Diagonostic Center"
        pointA.willUseImage = true
        
        let pointB = MyCustomPointAnnotation()
        pointB.coordinate = CLLocationCoordinate2D(latitude: 23.745401, longitude: 90.3846946)
        pointB.title = "LabAid Hospital"
        pointB.willUseImage = true
        
        let myPlaces = [pointA, pointB]
        mapView.addAnnotations(myPlaces)

    }
    

    func mapView(_ mapView: DingiMapView, viewFor annotation: DingiAnnotation) -> DingiAnnotationView? {
        
        if let castAnnotation = annotation as? MyCustomPointAnnotation {
            if (castAnnotation.willUseImage) {
                return nil
            }
        }
        
        // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
        let reuseIdentifier = "reusableDotView"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = DingiAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.layer.cornerRadius = (annotationView?.frame.size.width)! / 2
            annotationView?.layer.borderWidth = 4.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView!.backgroundColor = UIColor(red: 0.03, green: 0.80, blue: 0.69, alpha: 1.0)
        }
        
        return annotationView
    }
    
    // This delegate method is where you tell the map to load an image for a specific annotation based on the willUseImage property of the custom subclass.
    func mapView(_ mapView: DingiMapView, imageFor annotation: DingiAnnotation) -> DingiAnnotationImage? {
        
        if let castAnnotation = annotation as? MyCustomPointAnnotation {
            if (!castAnnotation.willUseImage) {
                return nil
            }
        }
        
        // For better performance, always try to reuse existing annotations.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "hospital")
        
        
        // If there is no reusable annotation image available, initialize a new one.
        if(annotationImage == nil) {
            annotationImage = DingiAnnotationImage(image: UIImage(named: "hospital")!, reuseIdentifier: "hospital")

        }
        
        return annotationImage
    }
    
    func mapView(_ mapView: DingiMapView, annotationCanShowCallout annotation: DingiAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }

}
