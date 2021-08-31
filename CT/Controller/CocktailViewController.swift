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
    
    private var drink: [String: String?]!
    
    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupView() {
        let url = URL(string: drink[Constants.Cocktail.ThumbStr]!!)
        cocktailImage.kf.setImage(with: url)
        cocktailName.text = drink[Constants.Cocktail.NameStr]!!
        cocktailCategory.text = drink[Constants.Cocktail.CategoryStr]!!
        cocktailCategory.text! += " " + String(drink[Constants.Cocktail.IdInt]!!)
        infoLabel.text = drink[Constants.Cocktail.InstructionsStr]!!
        
        var ingredients = ""
        var measures = ""
        for i in 1...Constants.numberOfIngredients {
            if let ingredient = drink[Constants.Cocktail.IngredientStr + String(i)] ?? nil {
                ingredients += ingredient + "\n"
                measures += ((drink[Constants.Cocktail.MeasureStr + String(i)] ?? "") ?? "") + "\n"
            }
        }
        ingredientNameLabel.text = ingredients
        ingredientMeasureLabel.text = measures

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
