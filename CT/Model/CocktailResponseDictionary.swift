//
//  CocktailResponseDictionary.swift
//  CT
//
//  Created by Andrii on 13.03.2021.
//

import Foundation

// MARK: - CocktailResponseDictionary
struct CocktailResponseDictionary: Codable {
    let drinks: [[String: String?]]
}
