//
//  WeatherModel.swift
//  testTask
//
//  Created by evilb on 30.07.2022.
//

import Foundation


struct WeatherModel: Codable {
    let weather: [Current]
    let main: Daily
    let wind: Wind
}

struct Current: Codable {
    let description: String
}

struct Wind: Codable {
    let speed: Float
}

//struct WeatherDescription: Codable {
//    let description: String?
//}

struct Daily: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}
//
//struct MinMaxTemp: Codable {
//    let min: Double
//    let max: Double
//}
