//
//  FavouirteTableViewCell.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import UIKit

class FavouirteTableViewCell: UITableViewCell {
    @IBOutlet weak var favouriteTitleLabel: UILabel!
    @IBOutlet weak var favouriteImageArticle: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Initialization code
        if #available(iOS 13.0, *) {
            
            
            self.favouriteTitleLabel.textColor = .secondaryLabel
            
            
        } else {
            // Fallback on earlier versions
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
