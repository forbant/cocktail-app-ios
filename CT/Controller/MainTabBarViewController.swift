//
//  TabBarViewController.swift
//  CT
//
//  Created by Andrii on 14.03.2021.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
    let ingredientCoordinator = IngredientCoordinator(navigationController: UINavigationController())
    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    let testCoordinator = TestCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()

        //testCoordinator.start()
        homeCoordinator.start()
        ingredientCoordinator.start()
        favoritesCoordinator.start()
        
        
        viewControllers = [
            favoritesCoordinator.navigationController,
            homeCoordinator.navigationController,
            ingredientCoordinator.navigationController,
        ]

        selectedIndex = viewControllers!.capacity / 2
        tabBar.tintColor = UIColor(named: "BrandLight")
        tabBar.barTintColor = UIColor(named: "BrandDarkGreen")
        tabBar.backgroundColor = UIColor(named: "BrandDarkGreen")
        tabBar.isTranslucent = false
        //tabBar.isOpaque = true
    }

}
