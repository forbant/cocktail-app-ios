//
//  HomeCoordinator.swift
//  CT
//
//  Created by Andrii on 20.09.2021.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinatros = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RootViewController.instantiate()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
