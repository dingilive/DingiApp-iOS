//
//  SnapshotViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class SnapshotViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!
    var button: UIButton!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = DingiMapView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2), styleURL: DingiStyle.englishStyleURL)
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        let center = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        mapView.setCenter(center, zoomLevel: 14, animated: false)
        view.addSubview(mapView)
        mapView.delegate = self
        
        // Create a button to take a map snapshot.
        button = UIButton(frame: CGRect(x: mapView.bounds.width / 2 - 40, y: mapView.bounds.height - 40, width: 80, height: 30))
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 1.0)
        button.setTitle("Snapshot", for: .normal)
        button.addTarget(self, action: #selector(createSnapshot), for: .touchUpInside)
        view.addSubview(button)
        
        // Create a UIImageView that will store the map snapshot.
        imageView = UIImageView(frame: CGRect(x: 0, y: view.bounds.height / 2, width: view.bounds.width, height: view.bounds.height / 2))
        imageView.backgroundColor = .black
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(imageView)

        // Do any additional setup after loading the view.
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: DingiMapView) {
        let hello = DingiPointAnnotation()
        hello.coordinate = CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078)
        hello.title = "Hello world!"
        hello.subtitle = "Welcome to my marker"
        mapView.addAnnotation(hello)
    }
    
    @objc func createSnapshot() {
        // Use the map's style, camera, size, and zoom level to set the snapshot's options.
        let options = DingiMapSnapshotOptions(styleURL: mapView.styleURL, camera: mapView.camera, size: mapView.bounds.size)
        options.zoomLevel = mapView.zoomLevel
        
        // Add an activity indicator to show that the snapshot is loading.
        let indicator = UIActivityIndicatorView(frame: CGRect(x: self.imageView.center.x - 30, y: self.imageView.center.y - 30, width: 60, height: 60))
        view.addSubview(indicator)
        indicator.startAnimating()
        
        // Create the map snapshot.
        var snapshotter: DingiMapSnapshotter? = DingiMapSnapshotter(options: options)
        snapshotter?.start { (snapshot, error) in
            if error != nil {
                print("Unable to create a map snapshot.")
            } else if let snapshot = snapshot {
                indicator.stopAnimating()
                let markerPosition = snapshot.point(for: CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078))
                self.imageView.image = self.drawImage(image: UIImage(named: "hospital")!, inImage: snapshot.image, atPoint: markerPosition)
            }
            
            snapshotter = nil
        }
    }
    
    func drawImage(image foreGroundImage:UIImage, inImage backgroundImage:UIImage, atPoint point:CGPoint) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(backgroundImage.size, false, 0.0)
        backgroundImage.draw(in: CGRect.init(x: 0, y: 0, width: backgroundImage.size.width, height: backgroundImage.size.height))
        foreGroundImage.draw(in: CGRect.init(x: point.x - foreGroundImage.size.width / 2, y: point.y - foreGroundImage.size.height, width: foreGroundImage.size.width, height: foreGroundImage.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    



}
