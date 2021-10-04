//
//  IngredientCell.swift
//  CT
//
//  Created by Andrii on 01.03.2021.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heart: UIImageView!
    
    var ingredientItem: IngredientItem? {
        didSet {
            mainLabel.text = ingredientItem?.name
            heart.isHidden = !(ingredientItem?.hearted ?? true)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
