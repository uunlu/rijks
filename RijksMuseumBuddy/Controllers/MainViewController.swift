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
    var topbar: UIView!
    var searchArtistLabel: UILabel!
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchView()
        setupTopbarView()
    }
    
    func setupTopbarView() {
        topbar = UIView(frame: CGRect.zero)
        topbar.backgroundColor = .black

        let searchLabel = UILabel(frame: CGRect.zero)
        searchLabel.text = "Rijks Museum"
        searchLabel.textColor = .systemGray6
        searchLabel.contentMode = .scaleAspectFit
        
        searchArtistLabel = UILabel(frame: CGRect.zero)
        searchArtistLabel.text = "Select an artist"
        searchArtistLabel.textColor = .systemGray6
        searchArtistLabel.textAlignment = .right
        searchArtistLabel.lineBreakMode = .byTruncatingTail
        searchArtistLabel.font = .systemFont(ofSize: 15)
        
        let labelStackView = UIStackView(arrangedSubviews: [searchLabel, searchArtistLabel])
        labelStackView.distribution = .fill
        labelStackView.axis = .horizontal
        
        topbar.addSubview(labelStackView)
        view.addSubview(topbar)
        
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        topbar.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeareaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            topbar.heightAnchor.constraint(equalToConstant: 40),
            topbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topbar.topAnchor.constraint(equalTo: searchCollectionView.bottomAnchor, constant: 5),
            labelStackView.leadingAnchor.constraint(equalTo: safeareaGuide.leadingAnchor, constant: 5),
            labelStackView.trailingAnchor.constraint(equalTo: safeareaGuide.trailingAnchor, constant: -5),
            labelStackView.topAnchor.constraint(equalTo: topbar.topAnchor, constant: 5),
            labelStackView.bottomAnchor.constraint(equalTo: topbar.bottomAnchor, constant: 5)
            
            
        ])
        
    }

    // MARK: - Helpers
    func setupSearchView() {
        let searchLayout = UICollectionViewFlowLayout()
        searchLayout.scrollDirection = .horizontal
        searchLayout.minimumLineSpacing = 0
        searchLayout.itemSize = CGSize(width: 100, height: 50)
        
        searchCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: searchLayout)
        
        searchCollectionView.autoresizingMask = [.flexibleWidth]
        searchCollectionView.backgroundColor = .black
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArtist = StaticDataFactory.artists[indexPath.row]
        print("--\(selectedArtist)")
        searchArtistLabel.text = selectedArtist
    }
}



