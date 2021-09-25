//
//  ListViewController.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import UIKit

class IngredientListViewController: UIViewController, Storyboarded {
    
    weak var coordinator: IngredientCoordinator?
    private var viewModel: IngredientListViewModel!
    
    @IBOutlet weak var tableList: UITableView!

    private var networkManager = NetworkManager()
    private var ingredientList: [IngredientItem]? {
        didSet {
            tableList.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableList.register(UINib(nibName: "IngredientCell", bundle: nil), forCellReuseIdentifier: "ingredientCell")
        tableList.dataSource = self
        tableList.delegate = self
        
        viewModel = IngredientListViewModel() //TODO: Inject
        bindeViewModel()
        viewModel.getAllIngredients()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bindeViewModel() {
        viewModel.updateIngredientList = { [weak self] ingredientList in
            self?.ingredientList = ingredientList
        }
    }

}

//MARK: - UITableViewDataSource
extension IngredientListViewController: UITableViewDataSource {
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
extension IngredientListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let name = ingredientList?[indexPath.row].name {
            viewModel.getIngredient(name: name)
        }

        if let name = ingredientList?[indexPath.row].name {
            networkManager.fetchIngredientByName(name: name) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let ingredient):
                        self.coordinator?.showIngredientDetails(ingredient)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
