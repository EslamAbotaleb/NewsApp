//
//  extension + TableView.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import UIKit
import CoreData
extension TopHeadLineViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopHeadLineTableViewCell.reuseIdentifier, for: indexPath) as? TopHeadLineTableViewCell else {
            fatalError("not found topheadline cell")
        }
     
        cell.configure(model: (self.articleSearch?.sorted(by: { $0.publishedAt! > $1.publishedAt! })[indexPath.row])!)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleSearch?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //(self.allArticles?[indexPath.row])!)!
        if let url = URL(string: (self.articleSearch?[indexPath.row].url)!), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .normal,
                                        title:  "Favourite") { [weak self] (action, view, completionHandler) in
            
            
            let entity = NSEntityDescription.entity(forEntityName: "ArticleData", in: (self?.context)!)
            let articleObject = NSManagedObject(entity: entity!, insertInto: self?.context)
            articleObject.setValue(self?.allArticles![indexPath.row].title, forKey: "title")
            articleObject.setValue(self?.allArticles![indexPath.row].urlToImage, forKey: "article_image")
            
            
            self?.handleMarkAsFavourite(article: articleObject)
            completionHandler(true)
            
            
            
            
            
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
}
