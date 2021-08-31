//
//  CocktailResponse.swift
//  CT
//
//  Created by Andrii on 02.03.2021.
//

import Foundation

// MARK: - CocktailResponse
struct CocktailResponse: Decodable {
    let drinks: [Drink]
}


// MARK: - Drink
struct Drink: Decodable {
    let idDrink, strDrink, strTags, strCategory: String?
    let strIBA, strAlcoholic, strGlass, strInstructions: String?
    let strDrinkThumb: String?
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    let strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
    let strIngredient13, strIngredient14, strIngredient15, strMeasure1: String?
    let strMeasure2, strMeasure3, strMeasure4, strMeasure5: String?
    let strMeasure6, strMeasure7, strMeasure8, strMeasure9: String?
    let strMeasure10, strMeasure11, strMeasure12, strMeasure13: String?
    let strMeasure14, strMeasure15: String?
}
