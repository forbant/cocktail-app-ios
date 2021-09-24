//
//  RootViewController.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    weak var coordinator: HomeCoordinator?
    private(set) var viewModel: Int
    
    var cocktailList: CocktailResponseDictionary!
    let defaults = UserDefaults.standard
    let repo = Repo()
    
    let networkManager = NetworkManager()
    var drink: Cocktail!
    var timer = Timer()
    
    init(viewModel: Int) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var caroucel: UICollectionView!
    @IBOutlet weak var searchEditText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caroucel.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "carouselCell")
        caroucel.delegate = self
        caroucel.dataSource = self
        
//        networkManager.fetchRandomList { (responseDictionary) in
//            DispatchQueue.main.async {
//                self.cocktailList = responseDictionary
//                self.caroucel.reloadData()
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        resetTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        guard let name = searchEditText.text else {
            return
        }
        performSearch(cocktailName: name)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        networkManager.fetchRandomCocktail { (randomDrink) in
            DispatchQueue.main.async {
                self.drink = randomDrink
                self.coordinator?.showCocktailDetails(cocktail: randomDrink)
            }
        }
    }

    @IBAction func toListButtonPressed(_ sender: UIButton) {
        networkManager.fetcCocktailsTop { (responceDictionary) in
            DispatchQueue.main.async {
                self.coordinator?.showCocktailList(drinks: responceDictionary.drinks)
            }
        }
    }
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        changeBanner()
    }
    
    @objc func changeBanner() {
        resetTimer()
        let index = caroucel.indexPathsForVisibleItems[0]
        debugPrint(index.row)
        let indexPath = IndexPath(item: index.row + 1, section: 0)
        caroucel.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        
    }
    
    func resetTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(changeBanner), userInfo: nil, repeats: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCocktailScreen" {
            let destination = segue.destination as! CocktailViewController
            destination.drink = self.drink
        }
            
    }
    
    func performSearch(cocktailName: String) {
        defaults.setValue(cocktailName, forKey: "Search_history")
        repo.getCocktailByName(cocktailName) { coctail in
            DispatchQueue.main.async {
                self.drink = coctail
                self.performSegue(withIdentifier: "toCocktailScreen", sender: self)
            }
        }
    }
}

//MARK: - UITableViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktailList?.drinks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = caroucel.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CollectionViewCell
        let imageUrl = URL(string: cocktailList.drinks[indexPath.row][Constants.CocktailURLKeys.thumb]!!)
        cell.mainImage.kf.setImage(with: imageUrl)
        cell.cocktailName.text = cocktailList.drinks[indexPath.row][Constants.CocktailURLKeys.name]!!
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let coctail = cocktailList.drinks[indexPath.row]
        networkManager.fetchCocktailById(id: coctail[Constants.CocktailURLKeys.id]!!) { (response) in
            DispatchQueue.main.async {
                let cocktail = response.drinks[0]
                self.coordinator?.showCocktailDetails(cocktail: cocktail)
            }
        }
        
        return false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetTimer()
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.caroucel.bounds.width, height: self.caroucel.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
