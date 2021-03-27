//
//  ShowAllFavouritesViewController.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import UIKit
import CoreData
class ShowAllFavouritesViewController: UIViewController {
    var context:NSManagedObjectContext!
    var articleObjects : [NSManagedObject]?
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        openDatabse()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backbutton = UIButton(type: .custom)
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(backToArticles), for: .touchUpInside)

          self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nib = UINib(nibName: "FavouirteTableViewCell", bundle: nil)
       tableView.register(nib, forCellReuseIdentifier: FavouirteTableViewCell.reuseIdentifier)
        
        
    }
    
    @objc func backToArticles() {
        self.dismiss(animated: true, completion: nil)
    }
    func openDatabse()
    {
    
     guard let appDelegate =
       UIApplication.shared.delegate as? AppDelegate else {
         return
     }
     
    context =
       appDelegate.persistentContainer.viewContext
        
        fetchData()
    }
    func fetchData()
      {
          print("Fetching Data..")
          let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleData")
          request.returnsObjectsAsFaults = false
          do {
              let result = try context.fetch(request)
            self.articleObjects = result as? [NSManagedObject]
              for data in result as! [NSManagedObject] {
                  let title = data.value(forKey: "title") as! String
                  let article_image = data.value(forKey: "article_image") as! String
              }
          } catch {
              print("Fetching data Failed")
          }
      }

 

}
