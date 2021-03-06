//
//  UIViewController+Storyboarded.swift
//  CT
//
//  Created by Andrii on 20.09.2021.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}

extension UIViewController {
    func hideTabBar() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isTranslucent = true
    }
    
    func showTabBar() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isTranslucent = false
    }
}
