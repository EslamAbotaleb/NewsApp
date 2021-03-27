//
//  CategoiresViewController.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit

class CategoriesViewController: BaseViewController {
    var _selectedCells : NSMutableArray = []

    @IBOutlet weak var collectionView: UICollectionView!
    var allSources: [Source]?
    var categoriesSelected = [String]()
    var countryName: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nextBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(selectCategory))
         self.navigationItem.rightBarButtonItem  = nextBarButtonItem
        
        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CategoryCollectionViewCell")

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        NewsServiceApi.shared.getAllSources { (result) in
            self.showLoadingView()

            switch result {
            case .success(let allSources):
                
                self.allSources = allSources.sources
                 
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.dismissLoadingView()
                }

                break
            case .failure(let error):
                print(error)
            }
        }
    }
    @objc func selectCategory() {
        print(categoriesSelected)
        SavingManager.shared.saveValue(true, key: "categortSelect")
        SavingManager.shared.saveValue(self.categoriesSelected, key: "categoriesSelected")

        //Mark go to topheading screen
        let  topHeadlineController = TopHeadLineViewController(nibName: "TopHeadLineViewController", bundle: nil)

        let navigationConteoller = UINavigationController(rootViewController: topHeadlineController)
        navigationConteoller.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency

        self.present(navigationConteoller, animated: true, completion: nil)
        
    }


}
