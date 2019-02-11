//
//  LineFromGeoJsonViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class LineFromGeoJsonViewController: UIViewController, DingiMapViewDelegate {
    
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
           drawPolyline()
    }
    
    
    func drawPolyline() {
        // Parsing GeoJSON can be CPU intensive, do it on a background thread
        
        DispatchQueue.global(qos: .background).async(execute: {
            // Get the path for example.geojson in the app's bundle
            let jsonPath = Bundle.main.path(forResource: "line", ofType: "geojson")
            let url = URL(fileURLWithPath: jsonPath!)
            
            do {
                // Convert the file contents to a shape collection feature object
                let data = try Data(contentsOf: url)
                guard let shapeCollectionFeature = try DingiShape(data: data, encoding: String.Encoding.utf8.rawValue) as? DingiShapeCollectionFeature else {
                    fatalError("Could not cast to specified DingiShapeCollectionFeature")
                }
                print(shapeCollectionFeature.shapes.first as Any)
                if let polyline = shapeCollectionFeature.shapes.first as? DingiPolylineFeature {
                    polyline.title = polyline.attributes["name"] as? String
                    print(polyline.title as Any)
                    DispatchQueue.main.async(execute: {
                        [unowned self] in
                        self.mapView.addAnnotation(polyline)
                    })
                }
            } catch {
                print("GeoJSON parsing failed")
            }
            
        })
        
    }
    
    func mapView(_ mapView: DingiMapView, alphaForShapeAnnotation annotation: DingiShape) -> CGFloat {
        // Set the alpha for all shape annotations to 1 (full opacity)
        return 1
    }
    
    func mapView(_ mapView: DingiMapView, lineWidthForPolylineAnnotation annotation: DingiPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 2.0
    }
    
    func mapView(_ mapView: DingiMapView, strokeColorForShapeAnnotation annotation: DingiShape) -> UIColor {
        // Give our polyline a unique color by checking for its `title` property
        if (annotation.title == "Crema to Council Crest" && annotation is DingiPolyline) {
            // Mapbox cyan
            return UIColor(red: 59/255, green: 178/255, blue: 208/255, alpha: 1)
        } else {
            return .red
        }
    }
    

}
