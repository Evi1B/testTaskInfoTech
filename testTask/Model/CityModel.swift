//
//  CityModel.swift
//  testTask
//
//  Created by evilb on 30.07.2022.
//

import Foundation

struct CityModel: Codable {
    let name: String
    let coord: Coordination
}

struct Coordination: Codable {
    let lon: Double
    let lat: Double
}
