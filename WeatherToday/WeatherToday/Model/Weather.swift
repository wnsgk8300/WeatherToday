//
//  Weather.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/14.
//

import Foundation
import RxCocoa
import RxDataSources

struct Weather: WeatherDataType, Equatable {
    let date: Date?
    let icon: String
    let description: String
    let temperature: Double
    let maxTemperature: Double?
    let minTemperature: Double?
}

extension Weather {
    init(today: Today) {
        date = Date()
        icon = today.weather.first?.icon ?? ""
        description = today.weather.first?.description ?? "알 수 없음"
        temperature = today.main.temp
        maxTemperature = today.main.temp_max
        minTemperature = today.main.temp_min
    }
    
    init(forecastItem: Forecast.ListItem) {
        date = Date(timeIntervalSince1970: TimeInterval(forecastItem.dt))
        icon = forecastItem.weather.first?.icon ?? ""
        description = forecastItem.weather.first?.description ?? "알 수 없음"
        temperature = forecastItem.main.temp
        maxTemperature = nil
        minTemperature = nil
    }
}

extension Weather: IdentifiableType {
    var identity: Double {
        return date?.timeIntervalSinceReferenceDate ?? 0
    }
}


