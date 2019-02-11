//
//  PoiDetailsViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 11/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class PoiDetailsViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!
    let language = "en"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = DingiMapView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), styleURL: DingiStyle.englishStyleURL)
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mapView.delegate = self
        let center = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        mapView.setCenter(center, zoomLevel: 14, animated: false)
        view.addSubview(mapView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        mapView.addGestureRecognizer(singleTap)

    }
    
    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        let spot = sender.location(in: mapView)
        let features = mapView.visibleFeatures(at: spot)
        for feature in features{
            let id = feature.attribute(forKey: "_id")
            if id != nil{
                callFetchPoiDetails(id: id as! String)
                break
            }
        }
    }
    
    func callFetchPoiDetails(id: String){
        let url = URL(string: "https://api.dingi.live/maps/v2/place?id=\(id)&source=poi&language=\(language)")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("ru7KPUg2Wj17lRGdT1mTn9fCbYYSI2Ojaop8iwB5", forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, err) in
            do{
                let Result = try
                    JSONDecoder().decode(poiDetailsModel.self, from: data!)
                DispatchQueue.main.async {[weak self] in
                    if self!.mapView.annotations != nil{
                        for annotation in (self?.mapView.annotations!)!{
                            self!.mapView.removeAnnotation(annotation)
                        }
                    }
                    print(Result.result)
                    let hello = DingiPointAnnotation()
                    hello.coordinate = CLLocationCoordinate2D(latitude: Result.result.location[0], longitude: Result.result.location[1])
                    hello.title = Result.result.name
                    hello.subtitle = "\(Result.result.phone_no + " " + Result.result.website)"
                    self!.mapView.addAnnotation(hello)
                    self!.mapView.selectAnnotation(hello, animated: false)
                }
                
                
                
            } catch let jsonErr{
                print("Json parse error: ", jsonErr)
            }
            }.resume()
    }
    
    func mapView(_ mapView: DingiMapView, annotationCanShowCallout annotation: DingiAnnotation) -> Bool {
        return true
    }
    
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

}
