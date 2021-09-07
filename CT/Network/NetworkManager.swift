//
//  NetworkManager.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import Foundation

struct NetworkManager {
    
    private let headers = [
        "x-rapidapi-key": "bcf951e61dmsh80050fe8b09a3c9p1aeb26jsnf850217a89df",
        "x-rapidapi-host": "the-cocktail-db.p.rapidapi.com"
    ]
    
    private let baseUrl = "https://the-cocktail-db.p.rapidapi.com/"
    
    private enum EndPoints: String {
        case ingredientList = "list.php?i=list"
        case topList = "popular.php"
        case search = "search.php?s="
        case searchIngredient = "search.php?i="
        case randomCocktailEndpoint = "random.php"
        case randomSelection = "randomselection.php"
        case searchCocktailById = "lookup.php?i="
    }
    
    func fetchCocktailByName(name: String, completionHandler: @escaping ([String: String?]?) -> Void) {
        let request = buildRequest(for: .search, param: name)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData.drinks[0])
            } catch {
                debugPrint(error)
                completionHandler(nil)
            }
        }
    }
    
    func fetchCocktailByNameAsData(_ name: String, completionHandler: @escaping (Data) -> Void) {
        let request = buildRequest(for: .search, param: name)

        fetch(for: request) { (data) in
            completionHandler(data)
        }
    }
    
    func fetchIngredients(completionHandler: @escaping ([IngredientItem]) -> Void) {
        let request = buildRequest(for: .ingredientList)
        
        fetch(for: request) { (data) -> Void in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponse.self, from: data)
                let ingredients = decodedData.drinks.map({ return IngredientItem(name: $0.strIngredient1 ?? "None")})
                completionHandler(ingredients)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func fetchIngredientByName(name: String, completionHandler: @escaping (Result<Ingredient, Error>) -> Void) {
        let request = buildRequest(for: .searchIngredient, param: name)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                if let decodedData = try decoder.decode(IngredientResponse.self, from: data).ingredients.first {
                    completionHandler(.success(decodedData))
                } else {
                    completionHandler(.failure(NetworkError.badResponse))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchCocktailById(id: String,completionHadler: @escaping (CocktailResponseDictionary) -> Void) {
        let request = buildRequest(for: .searchCocktailById, param: id)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            
            do{
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHadler(decodedData)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func fetchRandomCocktail(completionHandler: @escaping ([String: String?]) -> Void) {
        let request = buildRequest(for: .randomCocktailEndpoint)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData.drinks[0])
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func fetcCocktailsTop(completionHandler: @escaping (CocktailResponseDictionary) -> Void) {
        let request = buildRequest(for: .topList)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func fetchRandomList(completionHandler: @escaping (CocktailResponseDictionary) -> Void) {
        let request = buildRequest(for: .randomSelection)
        
        fetch(for: request) { (data) in
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CocktailResponseDictionary.self, from: data)
                completionHandler(decodedData)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func buildImageURL(for string: String) -> URL? {
        let name = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string: "https://www.thecocktaildb.com/images/ingredients/" + name! + ".png")
    }
    
    private func fetch(for request: URLRequest, handler: @escaping (Data) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                debugPrint(error ?? "")
            }
            handler(data ?? Data())
        }
        task.resume()
    }
    
    private func buildRequest(for endpoint: EndPoints, param: String = "") -> URLRequest {
        let url = (baseUrl + endpoint.rawValue + param)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var request = URLRequest(url: URL(string: url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
}
