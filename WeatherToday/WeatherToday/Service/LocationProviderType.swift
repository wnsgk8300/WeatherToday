//
//  LocationProviderType.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationProviderType {
    @discardableResult
    func currentLocation() -> Observable<CLLocation>
    
    @discardableResult
    func currentAddress() -> Observable<String>
}
