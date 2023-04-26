//
//  StaticLocationProvider.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//


import Foundation
import CoreLocation
import RxSwift

//고정위치로 test용
struct StaticLocationProvider: LocationProviderType {
    @discardableResult
    func currentLocation() -> RxSwift.Observable<CLLocation> {
        return Observable.just(CLLocation.gangnamStation)
    }
    
    @discardableResult
    func currentAddress() -> RxSwift.Observable<String> {
        return Observable.just("강남역")
    }
    
    
}
