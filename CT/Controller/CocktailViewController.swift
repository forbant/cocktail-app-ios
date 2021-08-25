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
    
    //private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        print("CocktailViewController load")
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initView() {
        let url = URL(string: drink[K.Cocktail.ThumbStr]!!)
        cocktailImage.kf.setImage(with: url)
        cocktailName.text = drink[K.Cocktail.NameStr]!!
        cocktailCategory.text = drink[K.Cocktail.CategoryStr]!!
        cocktailCategory.text! += " " + String(drink[K.Cocktail.IdInt]!!)
        infoLabel.text = drink[K.Cocktail.InstructionsStr]!!
        
        var ingredients = ""
        var measures = ""
        for i in 1...K.numberOfIngredients {
            if let ingredient = drink[K.Cocktail.IngredientStr + String(i)] ?? nil {
                ingredients += ingredient + "\n"
                measures += ((drink[K.Cocktail.MeasureStr + String(i)] ?? "") ?? "") + "\n"
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
