//
//  TitleTextFieldCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 유준상 on 2022/08/10.
//

import RxSwift
import RxRelay

struct TitleTextFieldCellViewModel {
    let titleText = PublishRelay<String?>()
}
