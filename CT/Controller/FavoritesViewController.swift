//
//  FavoritesViewController.swift
//  CT
//
//  Created by Andrii on 18.03.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    

    @IBOutlet weak var favList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
        let tableCell = favList.dequeueReusableCell(withIdentifier: "coctailCell") as! CoctailTableViewCell
        return tableCell
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
}