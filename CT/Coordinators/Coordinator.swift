//
//  Coordinator.swift
//  CT
//
//  Created by Andrii on 20.09.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinatros: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
