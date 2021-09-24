//
//  FavoritesCoordinator.swift
//  CT
//
//  Created by Andrii on 21.09.2021.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    var childCoordinatros = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = FavoritesViewController.instantiate()
        vc.coordinator = self
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "heartTab"), tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }

}
