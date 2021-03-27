//
//  extension + Tableview.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import UIKit
extension ShowAllFavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouirteTableViewCell.reuseIdentifier, for: indexPath) as? FavouirteTableViewCell else {
            fatalError("not found topheadline cell")
        }
        
        cell.favouriteTitleLabel.text = self.articleObjects?[indexPath.row].value(forKey: "title") as? String
        
        
        
        cell.favouriteImageArticle.downloadImage(fromURL: (self.articleObjects?[indexPath.row].value(forKey: "article_image") as? String)!)

        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleObjects?.count ?? 0
    }
    
}
