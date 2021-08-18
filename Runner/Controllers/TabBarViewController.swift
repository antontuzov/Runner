//
//  TabBarViewController.swift
//  Runner
//
//  Created by Anton Tuzov on 17.08.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        tabBar.tintColor = UIColor.label
        setupViewControllers()
        
    }
    private func setupViewControllers() {
        viewControllers = [
            creatViwe(for: HomeViewController(), title: "Run", systemImage: "hare"),
            creatViwe(for: HistoryViewController(), title: "Logs", systemImage: "clock")
        ]
    }
    
    private func creatViwe(for viewController: UIViewController, title: String, systemImage: String) -> UIViewController {
        let iconSymbol = UIImage(systemName: systemImage)
        let selectedSymbol = UIImage(systemName: systemImage, withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        let tabBarItem = UITabBarItem(title: title, image: iconSymbol, selectedImage: selectedSymbol)
        viewController.tabBarItem = tabBarItem
        return viewController
    }

  

}
