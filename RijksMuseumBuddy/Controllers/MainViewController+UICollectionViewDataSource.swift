//
//  MainViewController+ViewDele.swift
//  MainViewController+ViewDele
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        StaticDataFactory.artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
        let data =  StaticDataFactory.artists[indexPath.row]
        cell.viewModel = SearchCellViewModel(title: data)
        return cell
    }
}
