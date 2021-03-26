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
    }
    func configure(model: Source) {
        self.nameCountryLb.text = model.country
    }
}
