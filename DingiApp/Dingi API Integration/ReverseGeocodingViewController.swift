//
//  ReverseGeocodingViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 11/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class ReverseGeocodingViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!
    var language = "en"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = DingiMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078), zoomLevel: 12, animated: false)
        mapView.delegate = self
        view.addSubview(mapView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
//        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
//            singleTap.require(toFail: recognizer)
//        }
        mapView.addGestureRecognizer(singleTap)

    }
    
    
    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        let spot = sender.location(in: mapView)
        let coord = mapView.convert(spot, toCoordinateFrom: mapView)
        callReverseGeocoding(coord: coord)
    }
    
    func callReverseGeocoding(coord: CLLocationCoordinate2D){
        let url = URL(string: "https://api.dingi.live/maps/v2/reverse/?lat=\(coord.latitude)&lng=\(coord.longitude)&language=\(language)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("ru7KPUg2Wj17lRGdT1mTn9fCbYYSI2Ojaop8iwB5", forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            do{
                let Result = try
                    JSONDecoder().decode(ReverseGeoCodeModel.self, from: data!)
                DispatchQueue.main.async {[weak self] in
                    if self!.mapView.annotations != nil{
                        for annotation in (self?.mapView.annotations!)!{
                            self!.mapView.removeAnnotation(annotation)
                        }
                    }
                 
                    let hello = DingiPointAnnotation()
                    hello.coordinate = coord
                    hello.title = "Address"
                    hello.subtitle = Result.result.address
                    self!.mapView.addAnnotation(hello)
                    self!.mapView.selectAnnotation(hello, animated: false)
                }
                
                
                
            } catch let jsonErr{
                print("Json parse error: ", jsonErr)
            }
            }.resume()
    }
    
    func mapView(_ mapView: DingiMapView, viewFor annotation: DingiAnnotation) -> DingiAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: DingiMapView, annotationCanShowCallout annotation: DingiAnnotation) -> Bool {
        return true
    }
    
    


}
