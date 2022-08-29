//
//  DetailListCell.swift
//  FindCVS
//
//  Created by 유준상 on 2022/08/25.
//

import SnapKit
import UIKit

class DetailListCell: UITableViewCell {
    let placeNameLabel = UILabel()
    let addressLabel = UILabel()
    let distanceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: DetailListCellData) {
        placeNameLabel.text = data.placeName
        addressLabel.text = data.address
        distanceLabel.text = "\(data.distance)m"
    }
    
    private func attribute() {
        backgroundColor = .white
        placeNameLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        
        addressLabel.font = .systemFont(ofSize: 14.0)
        addressLabel.textColor = .gray
        
        distanceLabel.font = .systemFont(ofSize: 12.0, weight: .light)
        distanceLabel.textColor = .darkGray
    }
    
    private func layout() {
        [placeNameLabel, addressLabel, distanceLabel]
            .forEach { contentView.addSubview($0) }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.leading.equalToSuperview().offset(18.0)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(3.0)
            $0.leading.equalTo(placeNameLabel)
            $0.bottom.equalToSuperview().inset(12.0)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.0)
        }
    }
}
