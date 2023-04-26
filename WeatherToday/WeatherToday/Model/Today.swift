//
//  Today.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/14.
//

import Foundation

struct Today: Codable {
    let dt: Int
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }

    let main: Main
}
