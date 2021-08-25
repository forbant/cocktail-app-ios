//
//  IngredientDetailsViewController.swift
//  CT
//
//  Created by Andrii on 01.03.2021.
//

import UIKit

class IngredientDetailsViewController: UIViewController {
    
    @IBOutlet weak var iamgeFromDB: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientAdditionalInfoLabel: UILabel!
    @IBOutlet weak var ingredientDescriptionLabel: UILabel!
    
    var textForUrl: String?
    var ingredient: Ingredient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ingredient = ingredient {
            iamgeFromDB.kf.setImage(with: buildImageURL(from: ingredient.strIngredient))
            ingredientNameLabel.text = ingredient.strIngredient
            ingredientDescriptionLabel.text = ingredient.strDescription
            ingredientAdditionalInfoLabel.text = ingredient.strType
            if let alcohol = ingredient.strABV {
                ingredientAdditionalInfoLabel.text! += " / \(alcohol)%"
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func buildImageURL(from string: String) -> URL? {
        let name = string.replacingOccurrences(of: " ", with: "%20")
        return URL(string: "https://www.thecocktaildb.com/images/ingredients/" + name + ".png")
    }

}
