//
//  ContentCollectionViewHeader.swift
//  NetflixStyleSampleApp
//
//  Created by 유준상 on 2022/03/29.
//

import Foundation
import UIKit
import SnapKit

class ContentCollectionViewHeader: UICollectionReusableView {
    
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
