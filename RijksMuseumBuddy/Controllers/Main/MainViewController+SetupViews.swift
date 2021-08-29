//
//  MainViewController+SetupView.swift
//  MainViewController+SetupView
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation
import UIKit

extension MainViewController {
    func configureViews() {
        setupSearchView()
        setupTopbarView()
        setupGalleryView()
        setupActivityIndicator()
        configureLayoutConstraints()
        
        searchTextField.delegate = self
    }
    
    private func setupActivityIndicator() {
        let layoutGuide = view.safeAreaLayoutGuide
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            layoutGuide.centerXAnchor.constraint(equalTo: loadingIndicator.centerXAnchor),
            layoutGuide.bottomAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 10)
        ])
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTopbarView() {
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
        
        // Second Row: Search Info & TextBar
        let infoStackView = UIStackView(arrangedSubviews: [searchLabel, searchArtistLabel])
        infoStackView.distribution = .fillEqually
        infoStackView.axis = .horizontal
        infoStackView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleHeight]
        
        topSearchContainerStackView = UIStackView(arrangedSubviews: [infoStackView, searchTextField])
        topSearchContainerStackView.axis = .vertical
        topSearchContainerStackView.distribution = .fillEqually
        topSearchContainerStackView.spacing = 0
        
        topbar.addSubview(topSearchContainerStackView)
        view.addSubview(topbar)
        
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        topbar.translatesAutoresizingMaskIntoConstraints = false
        topSearchContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLayoutConstraints() {
        let safeareaGuide = view.safeAreaLayoutGuide
        let heightAnchor: CGFloat = UIScreen.main.bounds.width > 500 ? 40: 80
        
        heightConstraint = topSearchContainerStackView.heightAnchor.constraint(equalToConstant: heightAnchor)
        
        NSLayoutConstraint.activate([
            heightConstraint,
            topbar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topbar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topbar.topAnchor.constraint(equalTo: searchBottomAnchor, constant: 5),
            topSearchContainerStackView.leadingAnchor.constraint(equalTo: safeareaGuide.leadingAnchor, constant: 10),
            topSearchContainerStackView.trailingAnchor.constraint(equalTo: topbar.trailingAnchor, constant: -10),
            topSearchContainerStackView.topAnchor.constraint(equalTo: topbar.topAnchor, constant: 5),
            topSearchContainerStackView.bottomAnchor.constraint(equalTo: topbar.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            galleryCollectionView.topAnchor.constraint(equalTo: topbar.bottomAnchor, constant: 5),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    private func setupSearchView() {
        let searchLayout = UICollectionViewFlowLayout()
        searchLayout.scrollDirection = .horizontal
        searchLayout.minimumLineSpacing = 0
        searchLayout.itemSize = CGSize(width: 100, height: 50)
        
        let searchCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: searchLayout)
        
        searchCollectionView.autoresizingMask = [.flexibleWidth]
        searchCollectionView.backgroundColor = .black
        searchCollectionView.isPagingEnabled = true
        
        view.addSubview(searchCollectionView)
        
        searchCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        searchCollectionView.dataSource = searchDatasource
        searchCollectionView.delegate = searchDatasource
        
        searchCollectionView.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: SearchCell.identifier)
        
        searchCollectionView.reloadData()
        NSLayoutConstraint.activate([
            searchCollectionView.heightAnchor.constraint(equalToConstant: 60),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        searchBottomAnchor = searchCollectionView.bottomAnchor
        
        searchDatasource.$selected
            .receive(on: RunLoop.main)
            .sink { selectedArtist in
                self.selectedArtist = selectedArtist
            }
            .store(in: &bag)
    }
    
    private func setupGalleryView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        galleryCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        galleryCollectionView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleHeight]
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        galleryCollectionView.backgroundColor = .black
        galleryCollectionView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(galleryCollectionView)
        
        galleryCollectionView.dataSource = dataSource
        galleryCollectionView.delegate = dataSource
        
        galleryCollectionView.register(UINib(nibName: "ArtCell", bundle: nil), forCellWithReuseIdentifier: ArtCell.identifier)
    }
    
}

extension MainViewController {
    // MARK: - Subscribe publishers
    func subscribeToPublishers() {
        // TODO: refactor | extract to self function
        vm.$items
            .receive(on: RunLoop.main)
            .sink { value in
                print("data fetched: \(value.count)")
                self.dataSource.updateData(value)
                self.galleryCollectionView.reloadData()
                self.loadingIndicator.stopAnimating()
            }
            .store(in: &bag)
        dataSource.$shouldFetch
            .receive(on: RunLoop.main)
            .sink { shouldFetch in
                if shouldFetch, !self.vm.collectionsResource!.isLoading {
                    self.loadingIndicator.startAnimating()
                    self.vm.fetch(maker: self.selectedArtist, query: self.query)
                }
            }
            .store(in: &bag)
        dataSource.$selectedCollection
            .receive(on: RunLoop.main)
            .sink { value in
                print(value)
                guard !value.isEmpty else { return }
                
                let targetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                targetVC.id = value
                self.present(targetVC, animated: true, completion: nil)
            }
            .store(in: &bag)
    }
}
