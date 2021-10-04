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
    public var ingredientList:[IngredientItem]? {
        didSet {
            if let ingredientList = ingredientList {
                self.updateIngredientList?(ingredientList)
            }
        }
    }
    private let userDefaults = UserDefaults.standard
    
    public var updateViewData: ((Ingredient) -> ())?
    public var updateFavorite: (()->())?
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
                    self?.ingredientList = self?.getHeartUpdatedList(of: ingredientsList)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }

    func heartTapped(_ ingredientName: String) {
        let currentValue = userDefaults.bool(forKey: ingredientName)
        userDefaults.set(!currentValue, forKey: ingredientName)
        updateFavorite?()
        ingredientList = getHeartUpdatedList(of: ingredientList)
    }

    func favoriteButtonImage(for name: String) -> String {
        let isFavorite = userDefaults.bool(forKey: name)
        if isFavorite {
            return "iconHeartSelected"
        } else {
            return "iconheart"
        }
    }

    private func getHeartUpdatedList(of list: [IngredientItem]?) -> [IngredientItem]? {
        return list?.map { return IngredientItem(name: $0.name, hearted: userDefaults.bool(forKey: $0.name)) }
    }

}
