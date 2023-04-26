//
//  WeatherURL.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/13.
//

import Foundation
import CoreLocation

let todayURL = "https://api.openweathermap.org/data/2.5/weather"
let forecastURL = "https://api.openweathermap.org/data/2.5/forecast"

func makeRequest(url: String, location: CLLocation) -> URLRequest {
    let urlStr = "\(url)?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&lang=kr&units=metric"
    let url = URL(string: urlStr)!
    print("url = ", url)
    return URLRequest(url: url)
}
