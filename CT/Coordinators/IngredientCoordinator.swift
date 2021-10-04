//
//  IngredientCoordinator.swift
//  CT
//
//  Created by Andrii on 21.09.2021.
//

import UIKit

class IngredientCoordinator: Coordinator {
    var childCoordinatros: [Coordinator] = [Coordinator]()
    private var viewModel: IngredientListViewModel!
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        viewModel = IngredientListViewModel()
    }
    
    func start() {
        let vc = IngredientListViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = viewModel
        vc.tabBarItem = UITabBarItem(title: "Ingredient", image: UIImage(named: "ListTab"), tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showIngredientDetails(_ ingredient: Ingredient) {
        let vc = IngredientDetailsViewController.instantiate()
        vc.ingredient = ingredient
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: false)
    }
    
    func popBack() {
        navigationController.popViewController(animated: false)
    }

}
