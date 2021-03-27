//
//  OnBoardingViewController.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/26/21.
//

import UIKit
import Moya
import Reachability

class CountryViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var allSources: [Source]?
    var _selectedCells : NSMutableArray = []
    var countrySelected = false
    var countryName: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoutBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(selectCountry))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        
        // Do any additional setup after loading the view.
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .secondarySystemBackground
        } else {
            // Fallback on earlier versions
        }
        collectionView.register(UINib(nibName: "CountriesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CountriesCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        NetworkReachability.shared.reach.whenReachable = { _ in
            self.getAllSourcesFromServer()
        }
        NetworkReachability.shared.reach.whenUnreachable = { _ in
            self.somethingError()
        }
        
        NetworkReachability.isReachable { _ in
            self.getAllSourcesFromServer()
        }
        
        
        NetworkReachability.isUnreachable { _ in
            self.somethingError()
            
        }
        
    }
    func somethingError() {
        self.showLoadingView()
        
        self.view.endEditing(true)
        let errorServiceLocalizations = ErrorServiceLocalizations.init(httpStatus: 0, errorType: .server)
        let errorTitle = errorServiceLocalizations.errorTitle
        let errorDescription = errorServiceLocalizations.errorDescription
        self.showErrorView(errorTitle: errorTitle, errorDescription: errorDescription)
        self.view.isUserInteractionEnabled = false
    }
    func getAllSourcesFromServer() {
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
    @objc func selectCountry() {
        
        let  categoryViewController = CategoriesViewController(nibName: "CategoriesViewController", bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: categoryViewController)
        navigationController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        categoryViewController.countryName = self.countryName
        SavingManager.shared.saveValue("CategorySelected", key: "selectCategory")
        
        self.present(navigationController, animated: true, completion: nil)
        //        }
    }
    
    
}
