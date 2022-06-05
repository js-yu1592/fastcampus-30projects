//
//  ProfileCollectionViewCell.swift
//  Outstagram
//
//  Created by 유준상 on 2022/06/05.
//

import Foundation
import SnapKit
import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    func setup(with image: UIImage) {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.backgroundColor = .tertiaryLabel
        imageView.image = image
    }
}
