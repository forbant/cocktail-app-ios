//
//  CocktailListViewController.swift
//  CT
//
//  Created by Andrii on 14.03.2021.
//

import UIKit
import Kingfisher

class CocktailListViewController: UIViewController {
    
    var cocktailList = [[String : String?]]()

    @IBOutlet weak var cocktailListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailListTable.register(UINib(nibName: "CoctailTableViewCell", bundle: nil), forCellReuseIdentifier: "coctailCell")
        cocktailListTable.delegate = self
        cocktailListTable.dataSource = self
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
        
        // TODO: Move to cell
        let imageUrl = URL(string: cocktailList[indexPath.row][Constants.CocktailURLKeys.ThumbStr]!!)
        cell.cocktailImage.kf.setImage(with: imageUrl)
        cell.cocktailName.text = cocktailList[indexPath.row][Constants.CocktailURLKeys.NameStr]!!
        cell.categoryName.text = cocktailList[indexPath.row][Constants.CocktailURLKeys.IdInt]!!

        return cell
    }
}

//MARK: - UITableViewDelegate

extension CocktailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("secected \(indexPath.row)")
    }
}
