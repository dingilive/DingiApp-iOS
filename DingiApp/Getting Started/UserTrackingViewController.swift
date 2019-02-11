//
//  UserTrackingViewController.swift
//  DingiApp
//
//  Created by Nafis Islam on 10/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import UIKit
import DingiMap

class UserTrackingViewController: UIViewController, DingiMapViewDelegate {
    
    var mapView: DingiMapView!
    @IBOutlet var button: UserLocationButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = DingiMapView(frame: view.bounds, styleURL: DingiStyle.englishStyleURL)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.tintColor = .blue
        mapView.attributionButton.tintColor = .lightGray
        view.addSubview(mapView)
        setupLocationButton()

    }
    
    @IBAction func locationButtonTapped(sender: UserLocationButton) {
        var mode: DingiUserTrackingMode
        
        switch (mapView.userTrackingMode) {
        case .none:
            mode = .follow
        case .follow:
            mode = .followWithHeading
        case .followWithHeading:
            mode = .followWithCourse
        case .followWithCourse:
            mode = .none
        }
        
        mapView.userTrackingMode = mode
        sender.updateArrowForTrackingMode(mode: mode)
    }
    
    func setupLocationButton() {
        button = UserLocationButton(buttonSize: 80)
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        button.tintColor = mapView.tintColor
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: button.frame.size.height),
            NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: button.frame.size.width)
        ]
        
        view.addConstraints(constraints)
    }
    

}

class UserLocationButton: UIButton {
    private var arrow: CAShapeLayer?
    private let buttonSize: CGFloat
    

    init(buttonSize: CGFloat) {
        self.buttonSize = buttonSize
        super.init(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.layer.cornerRadius = 4
        
        let arrow = CAShapeLayer()
        arrow.path = arrowPath()
        arrow.lineWidth = 2
        arrow.lineJoin = CAShapeLayerLineJoin.round
        arrow.bounds = CGRect(x: 0, y: 0, width: buttonSize / 2, height: buttonSize / 2)
        arrow.position = CGPoint(x: buttonSize / 2, y: buttonSize / 2)
        arrow.shouldRasterize = true
        arrow.rasterizationScale = UIScreen.main.scale
        arrow.drawsAsynchronously = true
        
        self.arrow = arrow
        
        updateArrowForTrackingMode(mode: .none)
        //
        layer.addSublayer(self.arrow!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func arrowPath() -> CGPath {
        let bezierPath = UIBezierPath()
        let max: CGFloat = buttonSize / 2
        bezierPath.move(to: CGPoint(x: max * 0.5, y: 0))
        bezierPath.addLine(to: CGPoint(x: max * 0.1, y: max))
        bezierPath.addLine(to: CGPoint(x: max * 0.5, y: max * 0.65))
        bezierPath.addLine(to: CGPoint(x: max * 0.9, y: max))
        bezierPath.addLine(to: CGPoint(x: max * 0.5, y: 0))
        bezierPath.close()
        
        return bezierPath.cgPath
    }
    
    func updateArrowForTrackingMode(mode: DingiUserTrackingMode) {
        let activePrimaryColor = UIColor.red
        let disabledPrimaryColor = UIColor.clear
        let disabledSecondaryColor = UIColor.black
        let rotatedArrow = CGFloat(0.66)
        
        switch mode {
        case .none:
            updateArrow(fillColor: disabledPrimaryColor, strokeColor: disabledSecondaryColor, rotation: 0)
        case .follow:
            updateArrow(fillColor: disabledPrimaryColor, strokeColor: activePrimaryColor, rotation: 0)
        case .followWithHeading:
            updateArrow(fillColor: activePrimaryColor, strokeColor: activePrimaryColor, rotation: rotatedArrow)
        case .followWithCourse:
            updateArrow(fillColor: activePrimaryColor, strokeColor: activePrimaryColor, rotation: 0)
        }
    }
    
    func updateArrow(fillColor: UIColor, strokeColor: UIColor, rotation: CGFloat) {
        guard let arrow = arrow else { return }
        arrow.fillColor = fillColor.cgColor
        arrow.strokeColor = strokeColor.cgColor
        arrow.setAffineTransform(CGAffineTransform.identity.rotated(by: rotation))
        
        if rotation > 0 {
            arrow.position = CGPoint(x: buttonSize / 2 + 2, y: buttonSize / 2 - 2)
        }
        
        layoutIfNeeded()
    }
}
