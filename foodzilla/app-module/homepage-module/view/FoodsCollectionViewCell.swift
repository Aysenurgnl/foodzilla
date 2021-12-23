//
//  FoodsCollectionViewCell.swift
//  foodzilla
//
//  Created by Ayşenur on 13.12.2021.
//

import UIKit

class FoodsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCostLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    public var indexPathRow: Int = 0
    private var shadowLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.layer.cornerRadius = favoriteButton.frame.size.width/2
        bottomView.makeCellShadow()
        bottomView.layer.shadowColor = UIColor.mainGreen.cgColor
        
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func layoutSubviews() {
        
    }
    
    override var bounds: CGRect {
        didSet {
          contentView.frame = bounds
        }
    }
}
