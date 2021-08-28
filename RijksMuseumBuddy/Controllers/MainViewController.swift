//
//  ViewController.swift
//  RijksMuseumBuddy
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    var searchCollectionView: UICollectionView!
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchView()
        
    }

    // MARK: - Helpers
    func setupSearchView() {
        let searchLayout = UICollectionViewFlowLayout()
        searchLayout.scrollDirection = .horizontal
        searchLayout.minimumLineSpacing = 0
        searchLayout.itemSize = CGSize(width: 100, height: 50)
        
        searchCollectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: searchLayout)
        
        searchCollectionView.autoresizingMask = [.flexibleWidth]
        searchCollectionView.backgroundColor = .systemGray2
        searchCollectionView.isPagingEnabled = true
        
        view.addSubview(searchCollectionView)
        
        searchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        
        searchCollectionView.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: SearchCell.identifier)
        
        NSLayoutConstraint.activate([
            searchCollectionView.heightAnchor.constraint(equalToConstant: 60),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
            ])
        
    }

}

// MARK: - Extensions Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
}



