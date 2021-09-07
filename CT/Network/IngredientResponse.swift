//
//  IngredientResponse.swift
//  CT
//
//  Created by Andrii on 20.03.2021.
//

import Foundation

// MARK: - IngredientResponse
struct IngredientResponse: Decodable {
    let ingredients: [Ingredient]
}

// MARK: - Ingredient
struct Ingredient: Decodable {
    let idIngredient, strIngredient: String
    let strDescription, strType, strAlcohol, strABV: String?
}
