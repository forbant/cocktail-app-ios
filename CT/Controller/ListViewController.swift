//
//  ListViewController.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableList: UITableView!

    private var networkManager = NetworkManager()
    private var ingredientListViewModel: IngredientListViewModel = IngredientListViewModel()
    private var ingredientList: [IngredientItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableList.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "ingredientCell")
        tableList.dataSource = self
        tableList.delegate = self

        networkManager.fetchIngredients { [weak self](ingredients) in
            self?.ingredientList = ingredients
            DispatchQueue.main.async {
                self?.tableList.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}

//MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientCell
        cell.ingredientItem = ingredientList?[indexPath.row]

        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = (storyboard?.instantiateViewController(identifier: "IngredientDetailsViewController"))! as IngredientDetailsViewController

        if let name = ingredientList?[indexPath.row].name {
            ingredientListViewModel.getIngredient(name: name)
        }

        if let name = ingredientList?[indexPath.row].name {
            networkManager.fetchIngredientByName(name: name) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let ingredient):
                        newVC.ingredient = ingredient
                        self.navigationController?.pushViewController(newVC, animated: true)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
