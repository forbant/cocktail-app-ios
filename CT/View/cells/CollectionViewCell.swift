//
//  CollectionViewCell.swift
//  CT
//
//  Created by Andrii on 15.03.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var shadow: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var cocktailName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImage.layer.cornerRadius = 8
        container.layer.cornerRadius = 8
        container.layer.shadowColor = UIColor.darkGray.cgColor
        container.layer.shadowRadius = 4.0
        container.layer.shadowOpacity = 1.0
        container.layer.shadowOffset = CGSize(width: 0, height: 0)
        // Initialization code
    }

}
