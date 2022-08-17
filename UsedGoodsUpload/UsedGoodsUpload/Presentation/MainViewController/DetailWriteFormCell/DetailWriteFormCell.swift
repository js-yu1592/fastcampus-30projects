//
//  DetailWriteFormCell.swift
//  UsedGoodsUpload
//
//  Created by 유준상 on 2022/08/10.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class DetailWriteFormCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let contentInputView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailWriteFormCellViewModel) {
        contentInputView.rx.text
            .bind(to: viewModel.contentValue)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        contentInputView.font = .systemFont(ofSize: 17.0)
    }
    
    private func layout() {
        contentView.addSubview(contentInputView)
        
        contentInputView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(300.0)
        }
    }
    
}
