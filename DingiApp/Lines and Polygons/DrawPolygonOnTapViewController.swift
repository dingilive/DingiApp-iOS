//
//  DrawPolygonOnTapViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class DrawPolygonOnTapViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!
    var polygon = DingiPolygon()
    var coordinates: [CLLocationCoordinate2D] = []

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
        coordinates.append(coord)
        draw()
    }
    
    func draw(){
        
        if mapView.annotations != nil{
            mapView.removeAnnotations(mapView.annotations!)
        }
        if coordinates.count < 1{
            return
        }
        for coordinate in coordinates{
            let point = DingiPointAnnotation()
            point.coordinate = coordinate
            mapView.addAnnotation(point)
        }
        polygon = DingiPolygon(coordinates: &coordinates, count: UInt(coordinates.count))
        mapView.addAnnotation(polygon)
        
    }
    
    func mapView(_ mapView: DingiMapView, alphaForShapeAnnotation annotation: DingiShape) -> CGFloat {
        return 0.2
    }


}
