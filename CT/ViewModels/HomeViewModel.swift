//
//  HomeViewModel.swift
//  CT
//
//  Created by Andrii on 04.10.2021.
//

import Foundation

class HomeViewModel: ViewModel {
    public var updateCarousel: (()->())?
    public var navigateToCocktailDetails: ((Cocktail)->())?
    private var timer = Timer()
    private var carousel: CocktailResponseDictionary? {
        didSet {
            updateCarousel?()
        }
    }

    private let networkManager = NetworkManager()

    public var carouselItems: [Cocktail]? {
        return carousel?.drinks
    }

    public var carouselItemsCount: Int? {
        return carousel?.drinks.count
    }

    init() {
        networkManager.fetchRandomList { response in
            DispatchQueue.main.async {
                self.carousel = response
            }
        }
    }

    func performSearch(cocktailName: String) {

    }

    func getRandomCocktail() {

    }

    func fetchCarouselList() {
        networkManager.fetchRandomList { responseList in
            DispatchQueue.main.async {
                self.carousel = responseList
            }
        }
    }

    func carouselItemSelected(_ index: Int) {
        if let selectedCocktail = carousel?.drinks[index] {
            navigateToCocktailDetails?(selectedCocktail)
        }
    }
}
