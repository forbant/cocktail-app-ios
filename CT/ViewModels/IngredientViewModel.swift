//
//  CocktailViewModel.swift
//  CT
//
//  Created by Andrii on 07.09.2021.
//

import Foundation

protocol IngredientViewModelProtocol {
    var updateViewData: ((Ingredient)->())? { get set }
    func fetchIngredient(name: String)
}

class IngredientViewModel: IngredientViewModelProtocol {
    
    private let network = NetworkManager()
    
    public var updateViewData: ((Ingredient) -> ())?
    
    internal func fetchIngredient(name: String) {
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

}
