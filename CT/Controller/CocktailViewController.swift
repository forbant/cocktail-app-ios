//
//  CocktailViewController.swift
//  CT
//
//  Created by Andrii on 02.03.2021.
//

import UIKit
import Kingfisher

class CocktailViewController: UIViewController {
    
    @IBOutlet weak var cocktailImage: UIImageView!
    @IBOutlet weak var cocktailName: UILabel!
    @IBOutlet weak var cocktailCategory: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientMeasureLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    var drink: [String: String?]!
    
    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func heartTapped(_ sender: UIButton) {
        if heartButton.backgroundImage(for: .normal) == UIImage(named: "iconHeartSelected") {
            heartButton.setBackgroundImage(UIImage(named: "iconheart"), for: .normal)
        } else {
            heartButton.setBackgroundImage(UIImage(named: "iconHeartSelected"), for: .normal)
        }
    }
}

private extension CocktailViewController {
    func setupView() {
        let url = URL(string: drink[Constants.CocktailURLKeys.ThumbStr]!!)
        cocktailImage.kf.setImage(with: url)
        cocktailName.text = drink[Constants.CocktailURLKeys.NameStr]!!
        cocktailCategory.text = drink[Constants.CocktailURLKeys.CategoryStr]!!
        cocktailCategory.text! += " " + String(drink[Constants.CocktailURLKeys.IdInt]!!)
        infoLabel.text = drink[Constants.CocktailURLKeys.InstructionsStr]!!
        
        var ingredients = ""
        var measures = ""
        
        //TODO: Change after response naming refactored
        for i in 1...Constants.numberOfIngredients {
            if let ingredient = drink[Constants.CocktailURLKeys.IngredientStr + String(i)] ?? nil {
                ingredients += ingredient + "\n"
                measures += ((drink[Constants.CocktailURLKeys.MeasureStr + String(i)] ?? "") ?? "") + "\n"
            }
        }
        ingredientNameLabel.text = ingredients
        ingredientMeasureLabel.text = measures

    }
}
