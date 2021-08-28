//
//  SearchDataSource.swift
//  SearchDataSource
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import UIKit

class SearchDataSource: NSObject, UICollectionViewDataSource {
    var model: [String] = [] //StaticDataFactory.artists
    
    override init() {
        super.init()
       // update(StaticDataFactory.artists)
    }
    
    func update(_ data: [String]) {
        model.append(contentsOf: data)
    }
    
    typealias DataModel = String
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  StaticDataFactory.artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        let data =  StaticDataFactory.artists[indexPath.row]
        cell.viewModel = SearchCellViewModel(title: data)
        return cell
    }
    
    
}

extension SearchDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = UIScreen.main.bounds.width/2
        if UIScreen.main.bounds.width > 500 {
            cellWidth = UIScreen.main.bounds.width/4
        }
        return CGSize(width: cellWidth - 5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    
}

protocol DataSourcable {
    associatedtype DataModel: Hashable
    var model: [DataModel] { get }
    func update(_ data: [DataModel])
}
