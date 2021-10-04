//
//  IngredientDetails.swift
//  CT
//
//  Created by Andrii on 25.09.2021.
//

import Foundation

struct IngredientDetails {
    let id: String
    let name: String
    let description: String?
    let type: String?
    let isAlcohol: String?
    let alcoholByVolume: String?
    var isFavorite: Bool

    init(ingredient: Ingredient, isFavorite: Bool) {
        id = ingredient.id
        name = ingredient.name
        description = ingredient.description
        type = ingredient.type
        isAlcohol = ingredient.isAlcohol
        alcoholByVolume = ingredient.alcoholByVolume
        self.isFavorite = isFavorite
    }

}
