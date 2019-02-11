//
//  PolygonFromGeoJsonViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class PolygonFromGeoJsonViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!

    override func viewDidLoad() {  
        super.viewDidLoad()

        mapView = DingiMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078),
                          zoomLevel: 11, animated: false)
        view.addSubview(self.mapView)
        mapView.delegate = self
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: DingiMapView) {
        drawPolygon()
    }
    
    func drawPolygon() {
        // Parsing GeoJSON can be CPU intensive, do it on a background thread
        
        DispatchQueue.global(qos: .background).async(execute: {
            // Get the path for example.geojson in the app's bundle
            let jsonPath = Bundle.main.path(forResource: "polygon", ofType: "geojson")
            let url = URL(fileURLWithPath: jsonPath!)
            
            do {
                // Convert the file contents to a shape collection feature object
                let data = try Data(contentsOf: url)
                guard let shapeCollectionFeature = try DingiShape(data: data, encoding: String.Encoding.utf8.rawValue) as? DingiShapeCollectionFeature else {
                    fatalError("Could not cast to specified DingiShapeCollectionFeature")
                }
                print(shapeCollectionFeature.shapes.first as Any)
                if let polygon = shapeCollectionFeature.shapes.first as? DingiPolygonFeature {
                    polygon.title = polygon.attributes["name"] as? String
                    DispatchQueue.main.async(execute: {
                        [unowned self] in
                        self.mapView.addAnnotation(polygon)
                    })
                }
            } catch {
                print("GeoJSON parsing failed")
            }
            
        })
        
    }
    
    func mapView(_ mapView: DingiMapView, alphaForShapeAnnotation annotation: DingiShape) -> CGFloat {
        return 0.45
    }

}
