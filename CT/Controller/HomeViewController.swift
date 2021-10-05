//
//  RootViewController.swift
//  CT
//
//  Created by Andrii on 26.02.2021.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    weak var coordinator: HomeCoordinator?
    weak var viewModel: HomeViewModel?
    
    var cocktailList: CocktailResponseDictionary!

    var drink: Cocktail!
    var timer = Timer()
    
    @IBOutlet weak var caroucel: UICollectionView!
    @IBOutlet weak var searchEditText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caroucel.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "carouselCell")
        caroucel.delegate = self
        caroucel.dataSource = self
        
        bindViewModel()
        viewModel?.fetchCarouselList()
    }

    private func bindViewModel() {
        viewModel?.updateCarousel = { [weak self] in
            self?.caroucel.reloadData()
        }
        viewModel?.navigateToCocktailDetails = { [weak self] cocktail in
            self?.coordinator?.showCocktailDetails(cocktail: cocktail)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let name = searchEditText.text {
            viewModel?.performSearch(cocktailName: name)
        }
    }
    
    @IBAction func buttonForRandomCocktailTapped(_ sender: UIButton) {
        viewModel?.getRandomCocktail()
    }

    @IBAction func toListButtonPressed(_ sender: UIButton) {
        print("TODO: toListButtonPressed")
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
    
    func performSearch(cocktailName: String) {
        //TODO: remove
//        repo.getCocktailByName(cocktailName) { coctail in
//            DispatchQueue.main.async {
//                self.drink = coctail
//                self.performSegue(withIdentifier: "toCocktailScreen", sender: self)
//            }
//        }
    }
}

//MARK: - UITableViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.carouselItemsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = caroucel.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CollectionViewCell
        if let imgUrl = viewModel?.carouselItems?[indexPath.row][Constants.CocktailURLKeys.thumb], let imgUrl = imgUrl {
            cell.mainImage.kf.setImage(with: URL(string: imgUrl))
        }
        if let name = viewModel?.carouselItems?[indexPath.row][Constants.CocktailURLKeys.name] {
            cell.cocktailName.text = name
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        viewModel?.carouselItemSelected(indexPath.row)

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
