//
//  ViewController.swift
//  RijksMuseumBuddy
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    // MARK: - UI Outlet Variables
    var searchBottomAnchor: NSLayoutYAxisAnchor!
//    var searchCollectionView: UICollectionView!
    var galleryCollectionView: UICollectionView!
    var topbar: UIView!
    var searchArtistLabel: UILabel!
    var topSearchContainerStackView: UIStackView!
    var searchTextField: UISearchTextField!
    
    lazy var dataSource: GalleryCollectionViewDataSource = {
        let dataSource = GalleryCollectionViewDataSource(data: [])
        dataSource.collectionView = galleryCollectionView
        return dataSource
    }()
    
    var vm = GalleryViewModel()
    var bag = Set<AnyCancellable>()
    var heightConstraint: NSLayoutConstraint!
    var selectedArtist: String = "" {
        didSet {
            updateUI()
        }
    }
    lazy var searchDatasource: TopCollectionViewDataSource = {
        TopCollectionViewDataSource(data: ["adad"])
    }()
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.fetch(searchQuery: StaticDataFactory.artists.first!)
        setupSearchView()
        setupTopbarView()
        setupGalleryView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Have the collection view re-layout its cells.
        coordinator.animate(
            alongsideTransition: { _ in
                let orient = UIApplication.shared.statusBarOrientation
                switch orient {
                case .portrait:
                    print("Portrait")
                    self.topSearchContainerStackView.axis = .vertical
                    self.topSearchContainerStackView.spacing = 0
                    self.heightConstraint.constant = 80
                    self.topSearchContainerStackView.invalidateIntrinsicContentSize()
                case .landscapeLeft,.landscapeRight :
                    print("Landscape")
                    self.topSearchContainerStackView.axis = .horizontal
                    self.topSearchContainerStackView.spacing = 10
                    self.heightConstraint.constant = 40
                default:
                    print("Anything But Portrait")
                }
            
                self.topSearchContainerStackView.layoutIfNeeded()
                self.galleryCollectionView.collectionViewLayout.invalidateLayout()
            },
            completion: { _ in }
        )
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        view.setNeedsUpdateConstraints()
    }
    
    // MARK: - Helpers
    func updateUI() {
        searchArtistLabel.text = selectedArtist
        dataSource.removeAll()
        vm.fetch(searchQuery: selectedArtist)
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
        
        // Second Row: Search Info & TextBar
        let infoStackView = UIStackView(arrangedSubviews: [searchLabel, searchArtistLabel])
        infoStackView.distribution = .fillEqually
        infoStackView.axis = .horizontal
        infoStackView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleHeight]
        
        // Search TextField
        searchTextField = UISearchTextField(frame: CGRect.zero)
        searchTextField.placeholder = "search..."
        searchTextField.textColor = .gray
        searchTextField.backgroundColor = .white
        searchTextField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
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
        
        configurateSearchContainerConstraints()
    }
    
    private func configurateSearchContainerConstraints() {
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
    }
    
    func setupSearchView() {
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
        
        let datasource = TopCollectionViewDataSource(data: [])
        searchCollectionView.dataSource = searchDatasource
        searchCollectionView.delegate = searchDatasource
        
        searchCollectionView.register(UINib(nibName: "SearchCell", bundle: nil), forCellWithReuseIdentifier: SearchCell.identifier)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            datasource.updateData([])
            searchCollectionView.reloadData()
        }
        NSLayoutConstraint.activate([
            searchCollectionView.heightAnchor.constraint(equalToConstant: 60),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        searchBottomAnchor = searchCollectionView.bottomAnchor
    }
    
    func setupGalleryView() {
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
        
        galleryCollectionView.register(UINib(nibName: "ArtCell", bundle: nil), forCellWithReuseIdentifier: "ArtCell")
        
        NSLayoutConstraint.activate([
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            galleryCollectionView.topAnchor.constraint(equalTo: topbar.bottomAnchor, constant: 5),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
        
        // TODO: refactor | extract to self function
        vm.$items
            .receive(on: RunLoop.main)
            .sink { value in
                print("data fetched: \(value.count)")
                self.dataSource.updateData(value)
                self.galleryCollectionView.reloadData()
            }
            .store(in: &bag)
        dataSource.$shouldFetch
            .receive(on: RunLoop.main)
            .sink { shouldFetch in
                if shouldFetch, !self.vm.collectionsResource!.isLoading {
                    self.vm.fetch(searchQuery: self.selectedArtist)
                }
            }
            .store(in: &bag)
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
        selectedArtist = StaticDataFactory.artists[indexPath.row]
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let positionX = scrollView.contentOffset.x
        if positionX > galleryCollectionView.contentSize.width - scrollView.frame.size.width - 30, !vm.collectionsResource!.isLoading {
            print("fetching data")
            vm.fetch(searchQuery:selectedArtist)
        }
    }
}
