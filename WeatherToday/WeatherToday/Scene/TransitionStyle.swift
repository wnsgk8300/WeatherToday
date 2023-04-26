//
//  TransitionStyle.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//

import Foundation

enum TransitionStyle {
   case root
   case push
   case modal
}


enum TransitionError: Error {
   case navigationControllerMissing
   case cannotPop
   case unknown
}
