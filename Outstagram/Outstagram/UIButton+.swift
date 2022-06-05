//
//  UIButton+.swift
//  Outstagram
//
//  Created by 유준상 on 2022/05/31.
//

import Foundation
import UIKit

extension UIButton {
    func setImage(systemName: String) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = .zero
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}
