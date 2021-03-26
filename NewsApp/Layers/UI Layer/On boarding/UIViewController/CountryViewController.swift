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
extension CountryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountriesCollectionViewCell.reuseIdentifier, for: indexPath) as? CountriesCollectionViewCell else {
            fatalError("Cannot found CountriesCollectionViewCell")
        }
        
            cell.nameCountryLb.text = self.allSources?.unique{$0.country}[indexPath.row].country

        if _selectedCells.contains(indexPath) {
        cell.isSelected=true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
            cell.nameCountryLb.textColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
        else{
        cell.isSelected=false
            cell.nameCountryLb.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        }
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
            
        return self.allSources?.unique{$0.country}.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

            //add the selected cell contents to _selectedCells arr when cell is selected
        countryName = (self.allSources?.unique{$0.country}[indexPath.row].country)!
            _selectedCells.add(indexPath)
            collectionView.reloadItems(at: [indexPath])
        }

        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

            //remove the selected cell contents from _selectedCells arr when cell is De-Selected

            _selectedCells.remove(indexPath)
         

            collectionView.reloadItems(at: [indexPath])
        }
}
extension CountryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
        }

        func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
           
            let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
            
            return CGSize(width: widthPerItem - 8, height: 250)
        }
}
