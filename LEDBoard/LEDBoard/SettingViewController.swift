//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by 유준상 on 2022/01/18.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject {
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: LEDBoardSettingDelegate?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    var ledText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addTargets()
    }
    
    private func configureView() {
        if let ledText = self.ledText {
            self.textField.text = ledText
        }
        self.changeTextColor(color: self.textColor)
        self.changeBackgroundColorButton(color: self.backgroundColor)
    }
    
    func addTargets() {
        yellowButton.addTarget(self, action: #selector(tapTextColorButton(_:)), for: .touchUpInside)
        purpleButton.addTarget(self, action: #selector(tapTextColorButton(_:)), for: .touchUpInside)
        greenButton.addTarget(self, action: #selector(tapTextColorButton(_:)), for: .touchUpInside)
        
        blackButton.addTarget(self, action: #selector(tapBackgroundColorButton(_:)), for: .touchUpInside)
        blueButton.addTarget(self, action: #selector(tapBackgroundColorButton(_:)), for: .touchUpInside)
        orangeButton.addTarget(self, action: #selector(tapBackgroundColorButton(_:)), for: .touchUpInside)
        
        saveButton.addTarget(self, action: #selector(tapSaveButton(_:)), for: .touchUpInside)
    }

    @objc func tapTextColorButton(_ sender: UIButton) {
        switch sender {
        case yellowButton:
            self.textColor = .yellow
        case purpleButton:
            self.textColor = .purple
        case greenButton:
            self.textColor = .green
        default:
            break
        }
        
        self.changeTextColor(color: self.textColor)
    }
    
    @objc func tapBackgroundColorButton(_ sender: UIButton) {
        switch sender {
        case blackButton:
            self.backgroundColor = .black
        case blueButton:
            self.backgroundColor = .blue
        case orangeButton:
            self.backgroundColor = .orange
        default:
            break
        }
        
        self.changeBackgroundColorButton(color: self.backgroundColor)
    }
    
    @objc func tapSaveButton(_ sender: UIButton) {
        delegate?.changedSetting(
            text: textField.text,
            textColor: self.textColor,
            backgroundColor: self.backgroundColor
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor) {
        self.yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
        self.purpleButton.alpha = color == UIColor.purple ? 1 : 0.2
        self.greenButton.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    private func changeBackgroundColorButton(color: UIColor) {
        self.blackButton.alpha = color == UIColor.black ? 1 : 0.2
        self.blueButton.alpha = color == UIColor.blue ? 1 : 0.2
        self.orangeButton.alpha = color == UIColor.orange ? 1 : 0.2
    }
}
