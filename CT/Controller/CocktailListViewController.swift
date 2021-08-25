//
//  CocktailListViewController.swift
//  CT
//
//  Created by Andrii on 14.03.2021.
//

import UIKit
import Kingfisher

class CocktailListViewController: UIViewController {
    
//    let cocktailList = ["blured", "cocktail_preview", "DemoImage", "blured", "cocktail_preview", "DemoImage", "blured", "cocktail_preview", "DemoImage", "blured", "cocktail_preview", "DemoImage", "blured", "cocktail_preview", "DemoImage"]
    
    var cocktailList = [[String : String?]]()

    @IBOutlet weak var cocktailListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailListTable.register(UINib(nibName: "CoctailTableViewCell", bundle: nil), forCellReuseIdentifier: "coctailCell")
        cocktailListTable.delegate = self
        cocktailListTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

}

//MARK: - UITableViewDataSource

extension CocktailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coctailCell") as! CoctailTableViewCell
        
        let imageUrl = URL(string: cocktailList[indexPath.row][K.Cocktail.ThumbStr]!!)
        cell.cocktailImage.kf.setImage(with: imageUrl)
        cell.cocktailName.text = cocktailList[indexPath.row][K.Cocktail.NameStr]!!
        cell.categoryName.text = cocktailList[indexPath.row][K.Cocktail.IdInt]!!

        return cell
    }
}

//MARK: - UITableViewDelegate

extension CocktailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("secected \(indexPath.row)")
//        let newVC = (storyboard?.instantiateViewController(identifier: "IngredientDetailsViewController"))! as IngredientDetailsViewController
//        newVC.textForUrl = "done"
//        navigationController?.pushViewController(newVC, animated: true)
    }
}
