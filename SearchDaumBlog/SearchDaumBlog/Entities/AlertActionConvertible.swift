//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 유준상 on 2022/08/03.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
