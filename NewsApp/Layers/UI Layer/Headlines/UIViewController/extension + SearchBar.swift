//
//  extension + SearchBar.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import UIKit
extension TopHeadLineViewController: UISearchBarDelegate {
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard !searchText.isEmpty else {
        articleSearch  = self.allArticles!
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        return
    }
    articleSearch = (self.allArticles?.filter {
        article in
        return article.title.lowercased().contains((searchBar.text?.lowercased())!)
        
    })!
//        self.tableView.reloadData()
    DispatchQueue.main.async {
        self.tableView.reloadData()
    }
}


}
