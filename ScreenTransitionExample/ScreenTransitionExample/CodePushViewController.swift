//
//  CodePushViewController.swift
//  ScreenTransitionExample
//
//  Created by 유준상 on 2022/01/18.
//

import UIKit

class CodePushViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            nameLabel.text = "My name is \(name)"
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
