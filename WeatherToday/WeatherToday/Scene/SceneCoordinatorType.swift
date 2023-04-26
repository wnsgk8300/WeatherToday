//
//  SceneCoordinatorType.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
   @discardableResult
   func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
   
   @discardableResult
   func close(animated: Bool) -> Completable
}
