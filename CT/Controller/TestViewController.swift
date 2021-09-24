//
//  TestViewController.swift
//  CT
//
//  Created by Andrii on 23.09.2021.
//

import UIKit

class TestViewController: UIViewController, Storyboarded {
    
    weak var coordinator: Coordinator?
    @IBOutlet weak var table: UITableView!
    
    let stubbedData = ["One", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "One", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "One", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "One", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "StubbedTableViewCell", bundle: nil), forCellReuseIdentifier: "SSS")
        table.delegate = self
        table.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TestViewController: UITableViewDelegate {
    
}

extension TestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stubbedData.capacity
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "SSS") as! StubbedTableViewCell
        cell.label.text = stubbedData[indexPath.row]
        return cell
    }
    
    
}
