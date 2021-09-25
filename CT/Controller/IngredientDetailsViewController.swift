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

    var ingredient: Ingredient!

    override func viewDidLoad() {
        super.viewDidLoad()
        iamgeFromDB.kf.setImage(with: NetworkManager().buildImageURL(for: ingredient.name))
        ingredientNameLabel.text = ingredient.name
        ingredientDescriptionLabel.text = ingredient.description
        if let alcohol = ingredient.alcoholByVolume, let type = ingredient.type {
            ingredientAdditionalInfoLabel.text = "\(type) / \(alcohol)%"
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBar()
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBar()
    }

}
