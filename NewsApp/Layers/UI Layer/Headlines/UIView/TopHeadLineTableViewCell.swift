//
//  TopHeadLineTableViewCell.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import UIKit

class TopHeadLineTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        if #available(iOS 13.0, *) {
            
            
            self.titleLabel.textColor = .secondaryLabel
            self.dateLabel.textColor = .secondaryLabel
            self.descriptionLabel.textColor = .secondaryLabel
            self.sourceNameLabel.textColor = .secondaryLabel

        } else {
            // Fallback on earlier versions
          
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //GetFormatedDate(date_string: viewModel.createdAt!, dateFormat: "yyyy-MM-dd HH:mm:ss")
    func configure(model: Article) {
        self.imageArticle.downloadImage(fromURL: model.urlToImage ?? "")
        self.titleLabel.numberOfLines = 0
        self.titleLabel.sizeToFit()
        self.titleLabel.text = model.title
        self.sourceNameLabel.text = model.source.name
//        let str = "2013-07-21T19:32:00Z"
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                          .withTime,
                                          
                                          .withColonSeparatorInTime]
        let date = formatter.date(from: model.publishedAt!)
         

        self.dateLabel.text = formatter.string(from: date!)

        self.descriptionLabel.text = model.articleDescription
    }
}

