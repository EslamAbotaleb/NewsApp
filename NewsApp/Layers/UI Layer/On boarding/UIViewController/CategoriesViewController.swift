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
    }


}
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else {
            fatalError("Cannot found CountriesCollectionViewCell")
        }
       


        //Show tickImage if the cell is selected and hide tickImage if cell is NotSelected/deSelected.or whatever action you want to perform in case of selection and deselection of cell.
        cell.nameCategoryLabel.text = self.allSources?.unique{$0.category}[indexPath.row].category

        if _selectedCells.contains(indexPath) {
        cell.isSelected=true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
            cell.nameCategoryLabel.textColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }
        else{
        cell.isSelected=false
            cell.nameCategoryLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        }

        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
            
        return self.allSources?.unique{$0.category}.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

            //add the selected cell contents to _selectedCells arr when cell is selected
        categoriesSelected.append((self.allSources?.unique{$0.category}[indexPath.row].category)!)
            _selectedCells.add(indexPath)
            collectionView.reloadItems(at: [indexPath])
        }

        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

            //remove the selected cell contents from _selectedCells arr when cell is De-Selected

            _selectedCells.remove(indexPath)
            categoriesSelected.remove(at: indexPath.row)

            collectionView.reloadItems(at: [indexPath])
        }
}
extension CategoriesViewController: UICollectionViewDelegateFlowLayout{
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
