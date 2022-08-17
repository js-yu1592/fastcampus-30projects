//
//  CodePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 유준상 on 2022/01/18.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            nameLabel.text = "My name is \(name)"
        }
        
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "joon")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
