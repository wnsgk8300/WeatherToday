//
//  ViewModelBindableType.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/14.
//

import UIKit

protocol ViewModelBindableType {
   associatedtype ViewModelType
   
   var viewModel: ViewModelType! { get set }
   func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
   mutating func bind(viewModel: Self.ViewModelType) {
      self.viewModel = viewModel
      loadViewIfNeeded()
      
      bindViewModel()
   }
}
