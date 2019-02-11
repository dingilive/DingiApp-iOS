//
//  NavigationAPIViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 11/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class NavigationAPIViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!
    let source_lat = 23.7925
    let source_lng = 90.4078
    let destination_lat = 23.7286
    let destination_lng = 90.3854
    let steps = false
    let criteria = "fastest" // 3 possible values: 'fastest', 'shortest', 'both'
    let language = "en"  // for English set 'en', for Bangla set 'bn'

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = DingiMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078), zoomLevel: 12, animated: false)
        mapView.delegate = self
        view.addSubview(mapView)


    }
    
    func mapViewDidFinishLoadingMap(_ mapView: DingiMapView) {
        callNavigationAPI()
    }
    
 
    func callNavigationAPI(){
        let url = URL(string: "https://api.dingi.live/maps/v2/navigation/driving/?steps=\(steps)&criteria=\(criteria)&coordinates=\(source_lng)a\(source_lat)b\(destination_lng)a\(destination_lat)&language=\(language)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("ru7KPUg2Wj17lRGdT1mTn9fCbYYSI2Ojaop8iwB5", forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            do{
                let Result = try
                    JSONDecoder().decode(NavigationModel.self, from: data!)
                let temp = Polyline(encodedPolyline: (Result.routes.first?.geometry)!, encodedLevels: nil, precision: 1e6)
                let polyline = DingiPolyline(coordinates: temp.coordinates!, count: UInt(temp.coordinates!.count))
                DispatchQueue.main.async {[weak self] in
                    self!.mapView.addAnnotation(polyline)
                    self?.mapView.setVisibleCoordinateBounds(polyline.overlayBounds, animated: false)
                }
               
               

            } catch let jsonErr{
                print("Json parse error: ", jsonErr)
            }
            }.resume()
    }
    


}
