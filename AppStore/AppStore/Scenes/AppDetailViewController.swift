//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by 유준상 on 2022/05/19.
//

import Foundation
import SnapKit
import UIKit
import Kingfisher

final class AppDetailViewController: UIViewController {
    private let today: Today
    
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
       let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.layer.cornerRadius = 12.0
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapShareButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    init(today: Today) {
        self.today = today
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupViews()
        
        titleLabel.text = today.title
        subTitleLabel.text = today.subTitle
        
        if let imageURL = URL(string: today.imageURL) {
            appIconImageView.kf.setImage(with: imageURL)
        }
    }
}

private extension AppDetailViewController {
    func setupViews() {
        [
            appIconImageView,
            titleLabel,
            subTitleLabel,
            downloadButton,
            shareButton
        ].forEach { view.addSubview($0) }
        
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.height.equalTo(100.0)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(24.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(60.0)
        }
        
        shareButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(downloadButton.snp.bottom)
        }
    }
    
    @objc func didTapShareButton(_ sender: UIButton) {
        let activityItems: [Any] = [today.title]
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        
        present(activityViewController, animated: true)
    }
}
