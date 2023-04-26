//
//  WeatherApiType.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//

import Foundation
import CoreLocation
import RxSwift

protocol WeatherApiType {
    @discardableResult
    func fetch(location: CLLocation) -> Observable<(WeatherDataType?, [WeatherDataType])>
}
