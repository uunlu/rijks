//
//  GalleryCollectionViewDataSource.swift
//  GalleryCollectionViewDataSource
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit
import Foundation
import Combine

class GalleryCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    // MARK: Variables
    private let imageLoader = ImageLoader()
    private let cellWidth = UIScreen.main.bounds.width * 0.9
    
    var collectionView: UICollectionView?
    @Published var shouldFetch: Bool = false
    @Published var selectedCollection: String = ""
    
    // MARK: - DataSource Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtCell", for: indexPath) as! ArtCell
        guard data.count > indexPath.row else {
            return cell
        }
        let item = data[indexPath.row]
        var cellDTO = item.toArtDTO()
        cellDTO.imageLoader = imageLoader
        cell.viewModel =  cellDTO
        
        return cell
    }
    
    var data: [ArtObject]
    init(data: [ArtObject]){
        self.data = data
    }
    
    func updateData(_ data: [ArtObject]){
        self.data.append(contentsOf: data)
    }
    
    func removeAll() {
        data.removeAll()
    }
}

// MARK: - Flowlayout Extension
extension GalleryCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = floor(collectionView.bounds.height - 10)
        return CGSize(width: cellWidth, height: height)
    }
}

extension GalleryCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCollection = data[indexPath.row].objectNumber
    }
}

extension GalleryCollectionViewDataSource: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionX = scrollView.contentOffset.x
        if positionX > collectionView!.contentSize.width - scrollView.frame.size.width - 30 {
            shouldFetch = true
        }else{
            shouldFetch = false
        }
    }
}
