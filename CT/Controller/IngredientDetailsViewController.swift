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
    weak var viewModel: IngredientListViewModel?

    var ingredient: Ingredient!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindeViewModel()
        updateDetailsData()
    }

    private func bindeViewModel() {
        viewModel?.updateFavorite = { [weak self] in
            self?.updateFavoriteIcon()
        }
    }

    private func updateDetailsData() {
        iamgeFromDB.kf.setImage(with: NetworkManager().buildImageURL(for: ingredient.name))
        ingredientNameLabel.text = ingredient.name
        ingredientDescriptionLabel.text = ingredient.description
        if let alcohol = ingredient.alcoholByVolume, let type = ingredient.type {
            ingredientAdditionalInfoLabel.text = "\(type) / \(alcohol)%"
        }
        updateFavoriteIcon()
    }

    private func updateFavoriteIcon() {
        if let iconName = viewModel?.favoriteButtonImage(for: ingredient.name) {
            favoriteButton.setBackgroundImage(UIImage(named: iconName), for: .normal)
        }
    }

    @IBAction func heartTapped(_ sender: UIButton) {
        viewModel?.heartTapped(ingredient.name)
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
