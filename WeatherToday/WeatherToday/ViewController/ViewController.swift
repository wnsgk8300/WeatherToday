//
//  ViewController.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/13.
//

import UIKit
import RxSwift

class ViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MainViewModel!
    
    let locationLabel = UILabel()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let backgroundImageView = UIImageView()
    
    func bindViewModel() {
        print(#function)
        viewModel.title
            .bind(to: locationLabel.rx.text)
            .disposed(by: rx.disposeBag)
        viewModel.weatherData
            .drive(tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.register(TodayTableViewCell.self, forCellReuseIdentifier: TodayTableViewCell.identifier)
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.identifier)
    }
    
    var topInset: CGFloat = 0.0
    override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       if topInset == 0.0 {
          let first = IndexPath(row: 0, section: 0)
          if let cell = tableView.cellForRow(at: first) {
             topInset = tableView.frame.height - cell.frame.height
              tableView.contentInset = UIEdgeInsets(top: topInset - 40, left: 0, bottom: 0, right: 0)
          }
       }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else {
            return 80
        }
    }
}

// MARK: - UI
extension ViewController {
    final private func setUI() {
        setBasics()
        setLayout()
    }
    final private func setBasics() {
        backgroundImageView.image = UIImage(named: "galaxy")
        
        locationLabel.backgroundColor = .clear
        locationLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        locationLabel.textColor = .white
        locationLabel.textAlignment = .center
        locationLabel.text = "강남구"
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
    }
    final private func setLayout() {
        [backgroundImageView, locationLabel, tableView].forEach {
            view.addSubview($0)
        }
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom)
        }
        
    }
}
