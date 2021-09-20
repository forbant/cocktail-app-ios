//
//  TabBarViewController.swift
//  CT
//
//  Created by Andrii on 14.03.2021.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let home = HomeCoordinator(navigationController: UINavigationController())
    let ingredient = IngredientCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        home.start()
        ingredient.start()
        
        viewControllers = [home.navigationController, ingredient.navigationController]
    }

}
