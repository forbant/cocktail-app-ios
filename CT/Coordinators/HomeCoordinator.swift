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
    var viewModel: HomeViewModel
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        viewModel = HomeViewModel()
    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = viewModel
        vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "HomeTab"), tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showCocktailDetails(cocktail: Cocktail) {
        let vc = CocktailViewController.instantiate()
        vc.drink = cocktail
        vc.coordinator = self
        navigationController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCocktailList(drinks: [Cocktail]) {
        let vc = CocktailListViewController.instantiate()
        vc.coordinator = self
        vc.cocktailList = drinks
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dissmissCocktilDetails() {
        navigationController.popViewController(animated: true)
    }
    
    
}
