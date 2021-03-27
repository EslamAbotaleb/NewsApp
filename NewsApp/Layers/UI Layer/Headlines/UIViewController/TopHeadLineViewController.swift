//
//  TopHeadLineViewController.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit

class TopHeadLineViewController: BaseViewController {
    lazy var searchBar:UISearchBar = UISearchBar()

    @IBOutlet weak var tableView: UITableView!
    var allArticles: [Article]?
    var articleSearch = [Article]()
    var countryName: String?
    var categoriesSelected: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        setupSearchBar()
        
        let nib = UINib(nibName: "TopHeadLineTableViewCell", bundle: nil)
       tableView.register(nib, forCellReuseIdentifier: TopHeadLineTableViewCell.reuseIdentifier)
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .secondarySystemBackground
//            self.searchBar.backgroundColor = .secondarySystemBackground
        } else {
            // Fallback on earlier versions
        }
        handleApiRequestFromServer()
    }
    
    func setupSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
            searchBar.placeholder = " Search"
            searchBar.sizeToFit()
        searchBar.isTranslucent = false
            searchBar.backgroundImage = UIImage()
            searchBar.delegate = self
            navigationItem.titleView = searchBar
    }
    
    private func handleApiRequestFromServer() {
        NewsServiceApi.shared.getTopHeadline(country: countryName ?? SavingManager.shared.getValue("countryName"), category: categoriesSelected?.randomElement() ?? SavingManager.shared.getStringArrayValue("categoriesSelected").randomElement()!) { (result) in
            self.showLoadingView()

            switch result {
            case .success(let topHeadline):
                
                self.allArticles = topHeadline.articles
                self.articleSearch = topHeadline.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.dismissLoadingView()
                }

                break
            case .failure(let error):
                print(error)
            }
        }
    }

}
