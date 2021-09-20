//
//  RootViewController.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import UIKit

class RootViewController: UIViewController, Storyboarded {
    
    weak var coordinator: HomeCoordinator?
    
    var cocktailList: CocktailResponseDictionary!
    let defaults = UserDefaults.standard
    let repo = Repo()
    
    @IBOutlet weak var caroucel: UICollectionView!
    @IBOutlet weak var searchEditText: UITextField!
    let networkManager = NetworkManager()
    var drink: [String: String?]!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caroucel.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "carouselCell")
        caroucel.delegate = self
        caroucel.dataSource = self
        
        // Do any additional setup after loading the view.
        
        networkManager.fetchRandomList { (responseDictionary) in
            DispatchQueue.main.async {
                self.cocktailList = responseDictionary
                self.caroucel.reloadData()
            }
        }
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
        debugPrint("let's search \(searchEditText.text ?? "")")
        guard let name = searchEditText.text else {
            return
        }
        performSearch(cocktailName: name)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        networkManager.fetchRandomCocktail { (randomDrink) in
            DispatchQueue.main.async {
                self.drink = randomDrink
                self.performSegue(withIdentifier: "toCocktailScreen", sender: self)
            }
        }
    }
    @IBAction func toListButtonPressed(_ sender: UIButton) {
        let cocktailListViewController = (storyboard?.instantiateViewController(identifier: "CocktailListViewController"))! as CocktailListViewController
        networkManager.fetcCocktailsTop { (responceDictionary) in
            DispatchQueue.main.async {
                cocktailListViewController.cocktailList = responceDictionary.drinks
                self.navigationController?.pushViewController(cocktailListViewController, animated: true)
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

extension RootViewController: UICollectionViewDataSource {
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

extension RootViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        debugPrint("perform segue to cocktail!")
        let coctail = cocktailList.drinks[indexPath.row]
        networkManager.fetchCocktailById(id: coctail[Constants.CocktailURLKeys.id]!!) { (response) in
            DispatchQueue.main.async {
                self.drink = response.drinks[0]
                self.performSegue(withIdentifier: "toCocktailScreen", sender: self)
            }
        }
        
        return false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetTimer()
    }
}


extension RootViewController: UICollectionViewDelegateFlowLayout{
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

extension UIViewController {

func showToast(message : String, font: UIFont) {
    
    let width = self.view.frame.width-100

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - width/2, y: self.view.frame.size.height-35, width: width, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1.0)
    toastLabel.numberOfLines = 0
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 4;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 1.0, delay: 1.4, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
