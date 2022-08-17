//
//  BlogList.swift
//  SearchDaumBlog
//
//  Created by 유준상 on 2022/08/03.
//

import UIKit
import RxSwift
import RxCocoa

final class BlogListView: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 50.0)
        )
    )
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: BlogListViewModel) {
        headerView.bind(viewModel.filterViewModel)
        
        viewModel.cellData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { tableView, row, data in
                let index = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlogListCell", for: index) as? BlogListCell else { return UITableViewCell() }
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .systemBackground
        self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        self.separatorStyle = .singleLine
        self.rowHeight = 100.0
        self.tableHeaderView = headerView
    }
    
}
