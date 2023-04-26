//
//  TodayTableViewCell.swift
//  WeatherToday
//
//  Created by JEON JUNHA on 2023/04/15.
//

import UIKit
import SnapKit

class TodayTableViewCell: UITableViewCell {
    
    static let identifier = "today"
    private let weatherImageView = UIImageView()
    private let statusLabel = UILabel()
    private let minMaxLabel = UILabel()
    private let currentTampLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        backgroundColor = UIColor.clear
        self.selectionStyle = .none
        statusLabel.textColor = UIColor.white
        minMaxLabel.textColor = statusLabel.textColor
        currentTampLabel.textColor = statusLabel.textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(from data: WeatherDataType, tempFormatter: NumberFormatter) {
       weatherImageView.image = UIImage.from(name: data.icon)
       statusLabel.text = data.description
       
       let max = data.maxTemperature ?? 0.0
       let min = data.minTemperature ?? 0.0
       
       let maxStr = tempFormatter.string(for: max) ?? "-"
       let minStr = tempFormatter.string(for: min) ?? "-"
       
       minMaxLabel.text = "최대 \(maxStr)º 최소 \(minStr)º"
             
       let currentStr = tempFormatter.string(for: data.temperature) ?? "-"
       
        currentTampLabel.text = "\(currentStr)º"
    }

}
extension TodayTableViewCell {
    
    final private func setUI() {
        setBasic()
        setLayout()
    }
    final private func setBasic() {
        statusLabel.font = UIFont.systemFont(ofSize: 30)
        // 셀 높이가 작아져도 글자가 안보이지 않게
        minMaxLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        currentTampLabel.font = UIFont.systemFont(ofSize: 100)
        currentTampLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    final private func setLayout() {
        [weatherImageView, statusLabel, minMaxLabel, currentTampLabel].forEach {
            self.contentView.addSubview($0)
        }
        weatherImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.leading.equalToSuperview()
        }
        statusLabel.snp.makeConstraints { make in
            make.height.centerY.equalTo(weatherImageView)
            make.leading.equalTo(weatherImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        minMaxLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView)
            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
            make.trailing.equalTo(statusLabel)
        }
        currentTampLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView)
            make.trailing.equalTo(statusLabel)
            make.top.equalTo(minMaxLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
}
