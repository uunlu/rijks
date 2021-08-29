//
//  SearchDataSource.swift
//  SearchDataSource
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import UIKit
import Combine

final class SearchDataSource: NSObject, UICollectionViewDataSource {
    @Published var selected: String = ""
    
    private var model: [String] = []
    
    override init() {
        super.init()
        model.append(contentsOf: StaticDataFactory.artists)
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        let data =  model[indexPath.row]
        cell.viewModel = SearchCellViewModel(title: data)
        return cell
    }
}

extension SearchDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
        selected = model[indexPath.row]
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
