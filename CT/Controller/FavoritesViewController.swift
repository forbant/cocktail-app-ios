//
//  FavoritesViewController.swift
//  CT
//
//  Created by Andrii on 18.03.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favList: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        favList.register(UINib(nibName: "CoctailTableViewCell", bundle: nil), forCellReuseIdentifier: "coctailCell")
        favList.delegate = self
        favList.dataSource = self
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return favList.dequeueReusableCell(withIdentifier: "coctailCell") as! CoctailTableViewCell
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
}
