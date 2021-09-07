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
    let id: String
    let name: String
    let description: String?
    let type: String?
    let isAlcohol: String?
    let alcoholByVolume: String?

    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case name = "strIngredient"
        case description = "strDescription"
        case type = "strType"
        case isAlcohol = "strAlcohol"
        case alcoholByVolume = "strABV"
    }
}

