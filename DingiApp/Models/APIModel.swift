//
//  APIModel.swift
//  DingiApp
//
//  Created by Nafis Islam on 11/2/19.
//  Copyright © 2019 Nafis Islam. All rights reserved.
//

import Foundation

public struct NavigationModel: Codable{
    var code: String
    var uuid: String
    var routes: [RouteModel]
}

public struct RouteModel: Codable{
    var mode: String
    var geometry: String
    var time: Float
    var distance: Float
}

public struct ReverseGeoCodeModel: Codable{
    var result: ReverseGeoCodeResult
}

public struct ReverseGeoCodeResult: Codable{
    var address: String
}

public struct poiDetailsModel: Codable{
    var result: poiDetailsModelResult
}
public struct poiDetailsModelResult: Codable{
    var phone_no: String
    var name: String
    var location: Array<Double>
    var type: String
    var address: String
    var website: String
}

public struct NearbyTypeModel: Codable{
    var result: [NearbyTypeResult]
}

public struct NearbyTypeResult: Codable{
    var id: String
    var type: String
    var location: Array<Double>
    var source: String
    var address: String
    var name: String
    
}

