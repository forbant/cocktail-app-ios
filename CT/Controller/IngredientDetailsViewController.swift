//
//  IngredientDetailsViewController.swift
//  CT
//
//  Created by Andrii on 01.03.2021.
//

import UIKit

class IngredientDetailsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var iamgeFromDB: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientAdditionalInfoLabel: UILabel!
    @IBOutlet weak var ingredientDescriptionLabel: UILabel!

    weak var coordinator: IngredientCoordinator?

    var ingredient: Ingredient?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideTabBar()
        if let ingredient = ingredient {
            iamgeFromDB.kf.setImage(with: NetworkManager().buildImageURL(for: ingredient.name))
            ingredientNameLabel.text = ingredient.name
            ingredientDescriptionLabel.text = ingredient.description
            ingredientAdditionalInfoLabel.text = ingredient.type
            if let alcohol = ingredient.alcoholByVolume {
                ingredientAdditionalInfoLabel.text! += " / \(alcohol)%"
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        showTabBar()
    }
    
    
    func hideTabBar() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isTranslucent = true
    }
    
    func showTabBar() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isTranslucent = false
    }

}
