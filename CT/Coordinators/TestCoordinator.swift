//
//  TestCoordinator.swift
//  CT
//
//  Created by Andrii on 23.09.2021.
//

import UIKit

class TestCoordinator: Coordinator {
    var childCoordinatros: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = TestViewController.instantiate()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
