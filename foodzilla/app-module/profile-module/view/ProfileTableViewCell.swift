//
//  ProfileTableViewCell.swift
//  foodzilla
//
//  Created by Ayşenur on 17.12.2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setCell(text:String,image:UIImage){
        self.profileLabel.text = text
        self.iconImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
