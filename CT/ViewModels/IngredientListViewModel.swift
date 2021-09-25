//
//  CocktailViewModel.swift
//  CT
//
//  Created by Andrii on 07.09.2021.
//

import Foundation

protocol IngredientListViewModelProtocol {
    var updateViewData: ((Ingredient)->())? { get set }
    func getIngredient(name: String)
}

class IngredientListViewModel: IngredientListViewModelProtocol {
    
    private let network = NetworkManager()
    
    public var updateViewData: ((Ingredient) -> ())?
    public var updateIngredientList: (([IngredientItem]) -> ())?

    func getIngredient(name: String) {
        network.fetchIngredientByName(name: name) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ingredient):
                    self.updateViewData?(ingredient)
                case .failure(let error):
                    self.updateViewData?(Ingredient(id: "0", name: "Error", description: error.localizedDescription, type: nil, isAlcohol: nil, alcoholByVolume: nil))
                }
            }
        }
    }

    func getAllIngredients() {
        network.fetchIngredients { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ingredientsList):
                    self?.updateIngredientList?(ingredientsList)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }

}
