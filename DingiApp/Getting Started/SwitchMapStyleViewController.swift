//
//  SwitchMapStyleViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 7/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class SwitchMapStyleViewController: UIViewController {
    
    let mapView = DingiMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the map's initial style, center coordinate, and zoom level
        mapView.styleURL = DingiStyle.banglaStyleURL
        mapView.setCenter(CLLocationCoordinate2D(latitude: 23.7925, longitude: 90.4078), zoomLevel: 13, animated: false)
        view.addSubview(mapView)
        
        // Create a UISegmentedControl to toggle between map styles
        let styleToggle = UISegmentedControl(items: ["Bangla", "English"])
        styleToggle.translatesAutoresizingMaskIntoConstraints = false
        styleToggle.tintColor = UIColor(red: 0.976, green: 0.843, blue: 0.831, alpha: 1)
        styleToggle.backgroundColor = UIColor(red: 0.973, green: 0.329, blue: 0.294, alpha: 1)
        styleToggle.layer.cornerRadius = 4
        styleToggle.clipsToBounds = true
        styleToggle.selectedSegmentIndex = 0
        view.insertSubview(styleToggle, aboveSubview: mapView)
        styleToggle.addTarget(self, action: #selector(changeStyle(sender:)), for: .valueChanged)
        
        // Configure autolayout constraints for the UISegmentedControl to align
        // at the bottom of the map view and above the Mapbox logo and attribution
        NSLayoutConstraint.activate([NSLayoutConstraint(item: styleToggle, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mapView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0)])
        NSLayoutConstraint.activate([NSLayoutConstraint(item: styleToggle, attribute: .bottom, relatedBy: .equal, toItem: mapView.logoView, attribute: .top, multiplier: 1, constant: -20)])

       
    }
    
    @objc func changeStyle(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.styleURL = DingiStyle.banglaStyleURL
        case 1:
            mapView.styleURL = DingiStyle.englishStyleURL
        default:
            mapView.styleURL = DingiStyle.banglaStyleURL
        }
    }
    



}
