//
//  Repo.swift
//  CT
//
//  Created by Andrii on 27.07.2021.
//

import Foundation

class Repo {
    
    private let networkManager = NetworkManager()
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    typealias Handler = (Cocktail) -> Void
    
    func getCocktailByName(_ name: String, handler: Handler) {
        guard let fetched = defaults.data(forKey: name.uppercased()) else {
            networkManager.fetchCocktailByNameAsData(name) { data in
                DispatchQueue.main.async {
                    self.defaults.setValue(data, forKey: name)
                    do {
                        let cocktail = try self.decoder.decode(CocktailResponseDictionary.self, from: data).drinks[0]
                    } catch {
                        print(error)
                    }
                }
            }
            return
        }
        
        let cocktail = decodeAsCocktail(from: fetched)
        handler(cocktail)
    }
    
    private func decodeAsCocktail(from data: Data) -> Cocktail {
        let decoded = try! decoder.decode(Cocktail.self, from: data)
        return decoded
    }
}
