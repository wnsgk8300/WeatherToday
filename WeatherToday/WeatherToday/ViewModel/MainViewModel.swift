//
//  MainViewModel.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx
import UIKit

typealias SectionModel = AnimatableSectionModel<Int, Weather>

class MainViewModel: HasDisposeBag {
    init(title: String, sceneCoordinator: SceneCoordinatorType, weatherApi: WeatherApiType, locationProvider: LocationProviderType) {
        self.title = BehaviorRelay(value: title)
        self.sceneCoordinator = sceneCoordinator
        self.weatherApi = weatherApi
        self.locationProvider = locationProvider
        
        locationProvider.currentAddress()
            .bind(to: self.title)
            .disposed(by: disposeBag)
    }
    
   static let tempFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.minimumFractionDigits = 0
      formatter.maximumFractionDigits = 1
      
      return formatter
   }()
   
   static let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.locale = Locale(identifier: "Ko_kr")
      return formatter
   }()
   
    let title: BehaviorRelay<String>
   
    let sceneCoordinator: SceneCoordinatorType
    let weatherApi: WeatherApiType
    let locationProvider: LocationProviderType
    
    var weatherData: Driver<[SectionModel]> {
        return locationProvider.currentLocation()
            .flatMap { [unowned self] in
                self.weatherApi.fetch(location: $0)
                    .asDriver(onErrorJustReturn: (nil, [WeatherDataType]()))
            }
            .map { (today, forecast) in
                var todayList = [Weather]()
                if let today = today as? Weather {
                    todayList.append(today)
                }
                return [
                SectionModel(model: 0, items: todayList),
                SectionModel(model: 1, items: forecast as! [Weather])
                ]
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    let dataSource: RxTableViewSectionedAnimatedDataSource<SectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<SectionModel> { (dataSource, tableView, indexPath, data) -> UITableViewCell in
            switch indexPath.section {
                case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TodayTableViewCell.identifier, for: indexPath) as! TodayTableViewCell
                cell.configure(from: data, tempFormatter: MainViewModel.tempFormatter)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell
                cell.configure(from: data, dateFormatter: MainViewModel.dateFormatter, tempFormatter: MainViewModel.tempFormatter)
                return cell
            }
        }
        return ds
    }()
}
