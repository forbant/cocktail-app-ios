//
//  IngredientResponse.swift
//  CT
//
//  Created by Andrii on 20.03.2021.
//

import Foundation

// MARK: - IngredientResponse
struct IngredientResponse: Codable {
    let ingredients: [Ingredient]
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let idIngredient, strIngredient: String
    let strDescription, strType, strAlcohol, strABV: String?
}
