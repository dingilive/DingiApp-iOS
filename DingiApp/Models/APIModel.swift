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
