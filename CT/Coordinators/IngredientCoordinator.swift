//
//  IngredientCoordinator.swift
//  CT
//
//  Created by Andrii on 21.09.2021.
//

import UIKit

class IngredientCoordinator: Coordinator {
    var childCoordinatros: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ListViewController.instantiate()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }

}
