//
//  CategoryCollectionViewCell.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    
      @IBOutlet weak var nameCategoryLabel: UILabel!
      override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }
      func configure(model: Source) {
          self.nameCategoryLabel.text = model.category
      }
}
