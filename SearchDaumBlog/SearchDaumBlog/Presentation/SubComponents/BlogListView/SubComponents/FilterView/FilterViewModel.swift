//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by 유준상 on 2022/08/08.
//

import Foundation
import RxSwift
import RxCocoa

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
}
