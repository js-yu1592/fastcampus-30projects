//
//  DetailWriteFormCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 유준상 on 2022/08/10.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    
    // View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
