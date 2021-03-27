//
//  CountriesCollectionViewCell.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit

class CountriesCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var nameCountryLb: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if #available(iOS 13.0, *) {
            
            
            self.nameCountryLb.textColor = .secondaryLabel
           

        } else {
            // Fallback on earlier versions
          
        }
        
    }
    func configure(model: Source) {
        self.nameCountryLb.text = model.country
    }
}
