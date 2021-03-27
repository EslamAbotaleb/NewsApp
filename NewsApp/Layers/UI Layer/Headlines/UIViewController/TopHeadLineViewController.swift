//
//  TopHeadLineViewController.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit
import CoreData
class TopHeadLineViewController: BaseViewController {
    lazy var searchBar:UISearchBar = UISearchBar()
    // MARK: Variables declearations
      let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
      var context:NSManagedObjectContext!
    @IBOutlet weak var tableView: UITableView!
    var allArticles: [Article]?
    var articleSearch = [Article]()
    var articleObject: [NSManagedObject]?
    var countryName: String?
    var categoriesSelected: [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nextBarButtonItem = UIBarButtonItem(title: "Favorites", style: .done, target: self, action: #selector(showFavoiutes))
         self.navigationItem.rightBarButtonItem  = nextBarButtonItem
        
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
        openDatabse()
    }

 
    @objc func showFavoiutes() {
//        fetchData()
        
        let  showAllFavouritesViewController = ShowAllFavouritesViewController(nibName: "ShowAllFavouritesViewController", bundle: nil)

        let navigationController = UINavigationController(rootViewController: showAllFavouritesViewController)
        navigationController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
    
        self.present(navigationController, animated: true, completion: nil)
        
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
    // MARK: Methods to Open, Store and Fetch data
       func openDatabse()
       {
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
       context =
          appDelegate.persistentContainer.viewContext
       }
    func handleMarkAsFavourite(article: NSManagedObject) {
        print("Marked as favourite")
        print("Storing Data..")
               do {
                   try context.save()
               } catch {
                   print("Storing data Failed")
               }
    }
    
}
