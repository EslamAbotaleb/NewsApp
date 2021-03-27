//
//  extension + CountryCollectionView.swift
//  NewsApp
//
//  Created by Islam Abotaleb on 3/27/21.
//

import UIKit
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
            if #available(iOS 13.0, *) {
                cell.nameCountryLb.textColor = .secondaryLabel
            } else {
                // Fallback on earlier versions
            }

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
