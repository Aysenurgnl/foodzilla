//
//  CartTableViewCell.swift
//  foodzilla
//
//  Created by Ayşenur on 14.12.2021.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var orderCountLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.borderWidth = 1
        mainView.layer.cornerRadius = 8
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor(red: 0.946, green: 0.966, blue: 0.988, alpha: 1).cgColor
        
        mainView.makeCellShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
