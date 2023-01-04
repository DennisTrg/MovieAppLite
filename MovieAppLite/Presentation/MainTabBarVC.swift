//
//  MainTabBarVC.swift
//  MovieAppLite
//
//  Created by Tung Truong on 28/12/2022.
//

import UIKit
import SnapKit

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVC()
    }
    
    private func setupVC(){
        viewControllers = [
        navigator(rootVC: HomeVC(), title: "Home", image: "film.fill"),
        navigator(rootVC: SearchVC(), title: "Search", image: "magnifyingglass")]
    }
    
    fileprivate func navigator(rootVC : UIViewController, title: String, image: String) -> UIViewController{
        
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: image)
        navigationVC.navigationBar.prefersLargeTitles = true
        
        return navigationVC
    }
}
