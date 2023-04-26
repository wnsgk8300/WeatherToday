//
//  Forecast.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/14.
//

import Foundation


struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    
    struct ListItem: Codable {
        let dt: Int
        
        struct Main: Codable {
            let temp: Double
        }

        let main: Main
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }

        let weather: [Weather]
    }
    
    let list: [ListItem]
}
