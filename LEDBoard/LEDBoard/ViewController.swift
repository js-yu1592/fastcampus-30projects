//
//  ViewController.swift
//  LEDBoard
//
//  Created by 유준상 on 2022/01/18.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem: UIBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(didTapSettingButton(_:)))
        navigationItem.setRightBarButton(barButtonItem, animated: true)
        
        self.contentsLabel.textColor = .yellow
    }

    @objc func didTapSettingButton(_ sender: UIBarButtonItem) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else { return }
        viewController.title = "설정"
        viewController.delegate = self
        viewController.ledText = self.contentsLabel.text
        viewController.textColor = self.contentsLabel.textColor
        viewController.backgroundColor = self.view.backgroundColor ?? .black
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ViewController: LEDBoardSettingDelegate {
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.contentsLabel.text = text
        }
        self.contentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
}
