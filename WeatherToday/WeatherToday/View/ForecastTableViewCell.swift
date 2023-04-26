//
//  ForecastTableViewCell.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "forecast"
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let statusLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        backgroundColor = UIColor.clear
        self.selectionStyle = .none
        statusLabel.textColor = UIColor.white
        dateLabel.textColor = statusLabel.textColor
        timeLabel.textColor = statusLabel.textColor
        temperatureLabel.textColor = statusLabel.textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(from data: WeatherDataType, dateFormatter: DateFormatter, tempFormatter: NumberFormatter) {
       dateFormatter.dateFormat = "M.d (E)"
       dateLabel.text = dateFormatter.string(for: data.date)
       
       dateFormatter.dateFormat = "HH:00"
       timeLabel.text = dateFormatter.string(for: data.date)
       
       weatherImageView.image = UIImage.from(name: data.icon)
       
       statusLabel.text = data.description

       let tempStr = tempFormatter.string(for: data.temperature) ?? "-"
       temperatureLabel.text = "\(tempStr)º"
    }
}
extension ForecastTableViewCell {
    
    final private func setUI() {
        setBasic()
        setLayout()
    }
    final private func setBasic() {
        
        statusLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        
        weatherImageView.tintColor = .white
        
        //label크기를 항상 text표시할 수 있도록
        temperatureLabel.setContentHuggingPriority(.required, for: .vertical)
        temperatureLabel.setContentHuggingPriority(.required, for: .horizontal)
        temperatureLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        temperatureLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        temperatureLabel.font = UIFont.systemFont(ofSize: 40, weight: .thin)
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .lightGray
    }
    final private func setLayout() {
        [dateLabel, timeLabel, weatherImageView, statusLabel, temperatureLabel].forEach {
            self.contentView.addSubview($0)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview()
        }
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(temperatureLabel)
            make.trailing.equalTo(temperatureLabel.snp.leading).offset(-10)
        }
        weatherImageView.snp.makeConstraints { make in
            make.centerY.equalTo(statusLabel)
            make.trailing.equalTo(statusLabel.snp.leading).offset(-10)
            make.width.height.equalTo(40)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.lessThanOrEqualTo(weatherImageView.snp.leading).offset(10)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateLabel)
            make.trailing.greaterThanOrEqualTo(weatherImageView.snp.leading).offset(10)
        }
    }
}
