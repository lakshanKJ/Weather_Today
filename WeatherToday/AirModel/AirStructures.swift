//
//  AirStructures.swift
//
//  CWK2
//  K.L.Jayathilake
//  20191165
//

import Foundation

struct CurrentAirPollution: Codable {
    
    let coord: Coord
    let list: [AirList]
}

struct Coord: Codable {
    let lon, lat: Double
    
    enum CodingKeys: String, CodingKey {
        case lon, lat
    }
}

struct AirList: Codable {
    let main: AirMain
    let components: AirComponents
    let dt: Int
}

struct AirMain: Codable {
    let aqi: Int
}

struct AirComponents: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}
