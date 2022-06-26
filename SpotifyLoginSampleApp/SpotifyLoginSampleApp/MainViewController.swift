//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 유준상 on 2022/02/25.
//

import Foundation
import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var profileUpdateButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.configureAddTarget()
    }
    
    private func configureAddTarget() {
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped(_:)), for: .touchUpInside)
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped(_:)), for: .touchUpInside)
        profileUpdateButton.addTarget(self, action: #selector(profileUpdateButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func profileUpdateButtonTapped(_ button: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "토끼"
        changeRequest?.commitChanges { [weak self] _ in
            guard let self = self else { return }
            let displayName = Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "고객"
            
            self.welcomeLabel.text = """
            환영합니다.
            \(displayName)님
            """
        }
    }
    
    @objc private func logoutButtonTapped(_ button: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            debugPrint("ERROR: signout \(signOutError.localizedDescription)")
        }
    }
    
    @objc private func resetPasswordButtonTapped(_ button: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
        
    }
    
}
