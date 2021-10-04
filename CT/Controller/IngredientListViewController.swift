//
//  ListViewController.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import UIKit

class IngredientListViewController: UIViewController, Storyboarded {

    weak var coordinator: IngredientCoordinator?
    weak var viewModel: IngredientListViewModel?

    @IBOutlet weak var tableList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableList.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "ingredientCell")
        tableList.dataSource = self
        tableList.delegate = self

        bindeViewModel()
        viewModel?.getAllIngredients()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bindeViewModel() {
        viewModel?.updateIngredientList = { [weak self] ingredientList in
            self?.tableList.reloadData()
        }
        viewModel?.updateViewData = { [weak self] in
            self?.coordinator?.showIngredientDetails()
        }
    }

}

//MARK: - UITableViewDataSource
extension IngredientListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.ingredientList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientCell
        cell.ingredientItem = viewModel?.ingredientList?[indexPath.row]

        return cell
    }
}

//MARK: - UITableViewDelegate
extension IngredientListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let name = viewModel?.ingredientList?[indexPath.row].name {
            viewModel?.getIngredient(name: name)
        }
    }
}
