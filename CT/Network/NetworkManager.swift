//
//  NetworkManager.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import Foundation

struct NetworkManager {
    
    let headers = [
        "x-rapidapi-key": "bcf951e61dmsh80050fe8b09a3c9p1aeb26jsnf850217a89df",
        "x-rapidapi-host": "the-cocktail-db.p.rapidapi.com"
    ]
    
    let baseUrl = "https://the-cocktail-db.p.rapidapi.com/"
    let ingredientList = "list.php?i=list"
    let topList = "popular.php"
    let search = "search.php?s="
    let searchIngredient = "search.php?i="
    let randomCocktailEndpoint = "random.php"
    let randomSelection = "randomselection.php"
    let searchCocktailById = "lookup.php?i="
    
    func fetchCocktailByName(name: String, completionHandler: @escaping ([String: String?]?) -> Void) {
        let request = buildRequest(for: search + name)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData.drinks[0])
            } catch {
                print(error)
                completionHandler(nil)
            }
        }
    }
    
    func fetchCocktailByNameAsData(_ name: String, completionHandler: @escaping (Data) -> Void) {
        let request = buildRequest(for: search + name)
        
        fetch(for: request) { (data) in
            completionHandler(data)
        }
    }
    
    func fetchIngredients(completionHandler: @escaping ([IngredientItem]) -> Void) {
        let request = buildRequest(for: ingredientList)
        
        fetch(for: request) { (data) -> Void in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponse.self, from: data)
                let ingredients = decodedData.drinks.map({ return IngredientItem(name: $0.strIngredient1 ?? "None")})
                completionHandler(ingredients)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchIngredientByName(name: String, completionHandler: @escaping (Ingredient?) -> Void) {
        let request = buildRequest(for: searchIngredient + name)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(IngredientResponse.self, from: data)
                completionHandler(decodedData.ingredients.first)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchCocktailById(id: String,completionHadler: @escaping (CocktailResponseDictionary) -> Void) {
        let request = buildRequest(for: searchCocktailById + id)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            
            do{
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHadler(decodedData)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchRandomCocktail(completionHandler: @escaping ([String: String?]) -> Void) {
        let request = buildRequest(for: randomCocktailEndpoint)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData.drinks[0])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetcCocktailsTop(completionHandler: @escaping (CocktailResponseDictionary) -> Void) {
        let request = buildRequest(for: topList)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchRandomList(completionHandler: @escaping (CocktailResponseDictionary) -> Void) {
        let request = buildRequest(for: randomSelection)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData)
            } catch {
                print(error)
            }
        }
    }
    
    private func fetch(for request: URLRequest, handler: @escaping (Data) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                print(error ?? "")
            }
            handler(data ?? Data())
        }
        task.resume()
    }
    
    private func buildRequest(for endpoint: String) -> URLRequest {
        let url = baseUrl + endpoint.replacingOccurrences(of: " ", with: "%20")
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
}
