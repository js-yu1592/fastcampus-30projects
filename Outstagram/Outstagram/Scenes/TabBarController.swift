//
//  TabBarController.swift
//  Outstagram
//
//  Created by 유준상 on 2022/05/31.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TabBar 설정
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        feedViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        viewControllers = [feedViewController, profileViewController]
    }
}
