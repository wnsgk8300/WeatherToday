//
//  Scene.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/14.
//

import UIKit

enum Scene {
   case main(MainViewModel)
}

extension Scene {
    func instantiate() -> UIViewController {
        switch self {
        case .main(let viewModel):
            var vc = ViewController()
            DispatchQueue.main.async {
                vc.bind(viewModel: viewModel)
        }
            return vc
        }
    }
}
