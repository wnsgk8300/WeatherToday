//
//  WeatherApi.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation
import NSObject_Rx

class WeatherApi: NSObject, WeatherApiType {
    private let todayRelay = BehaviorRelay<WeatherDataType?>(value: nil)
    private let forecastRelay = BehaviorRelay<[WeatherDataType]>(value: [])
    private let urlsession = URLSession.shared
    
    @discardableResult
    private func fetchToday(location: CLLocation) -> Observable<WeatherDataType?> {
        let request = makeRequest(url: todayURL, location: location)
        
        return urlsession.rx.data(request: request)
            .map { data -> Today in
                let decoder = JSONDecoder()
                print(data)
                return try decoder.decode(Today.self, from: data)
            }
            .map { Weather(today: $0) }
            .catchAndReturn(nil)
    }
    
    private func fetchForecast(location: CLLocation) -> Observable<[WeatherDataType]> {
        let request = makeRequest(url: forecastURL, location: location)
        
        return urlsession.rx.data(request: request)
            .map { data -> [Weather] in
                let decoder = JSONDecoder()
                print(data)
                let forecast = try decoder.decode(Forecast.self, from: data)
                return forecast.list.map(Weather.init)
            }
            .catchAndReturn([])
    }
    
    @discardableResult
    func fetch(location: CLLocation) -> RxSwift.Observable<(WeatherDataType?, [WeatherDataType])> {
        let today = fetchToday(location: location)
        let forecast = fetchForecast(location: location)
        
        Observable.zip(today, forecast)
            .subscribe(onNext: { [weak self] result in
                self?.todayRelay.accept(result.0)
                self?.forecastRelay.accept(result.1)
            })
            .disposed(by: rx.disposeBag)
        return Observable.combineLatest(todayRelay.asObservable(), forecastRelay.asObservable())
    }
}
