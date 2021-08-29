//
//  ViewController.swift
//  RijksMuseumBuddy
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    // MARK: - UI Outlet Variables
    var searchBottomAnchor: NSLayoutYAxisAnchor!
    var galleryCollectionView: UICollectionView!
    var topbar: UIView!
    var searchArtistLabel: UILabel!
    var topSearchContainerStackView: UIStackView!
    lazy var searchTextField: UISearchTextField = {
        let searchTextField = UISearchTextField(frame: CGRect.zero)
        searchTextField.placeholder = "search..."
        searchTextField.textColor = .gray
        searchTextField.backgroundColor = .white
        searchTextField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        return searchTextField
    }()
    
    // MARK: - Lazy Variables
    lazy var dataSource: GalleryCollectionViewDataSource = {
        let dataSource = GalleryCollectionViewDataSource(data: [])
        dataSource.collectionView = galleryCollectionView
        return dataSource
    }()
    lazy var vm: GalleryViewModel =  {
        GalleryViewModel()
    }()
    lazy var searchDatasource: SearchDataSource = {
        SearchDataSource()
    }()
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemGray2
        indicator.hidesWhenStopped = true
        return indicator
    }()

    var bag:Set<AnyCancellable> = Set<AnyCancellable>()
    var heightConstraint: NSLayoutConstraint!
    var selectedArtist: String = "" {
        didSet {
            updateUI()
        }
    }
    var query: String = ""
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        subscribeToPublishers()
        
        // Fetch initial data on view
        vm.fetch(maker: StaticDataFactory.artists.first!)
        loadingIndicator.startAnimating()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // Have the collection view re-layout its cells.
        coordinator.animate(
            alongsideTransition: { _ in
                self.updateUIConstraints()
            },
            completion: { _ in }
        )
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        view.setNeedsUpdateConstraints()
    }
    
    // MARK: - Helpers
    private func updateUI() {
        searchArtistLabel.text = selectedArtist
        dataSource.removeAll()
        vm.fetch(maker: selectedArtist)
        loadingIndicator.startAnimating()
    }
    
    private func updateUIConstraints() {
        let orient = self.view.window?.windowScene?.interfaceOrientation
        switch orient {
        case .portrait:
            self.topSearchContainerStackView.axis = .vertical
            self.topSearchContainerStackView.spacing = 0
            self.heightConstraint.constant = 80
            self.topSearchContainerStackView.invalidateIntrinsicContentSize()
        case .landscapeLeft,.landscapeRight :
            self.topSearchContainerStackView.axis = .horizontal
            self.topSearchContainerStackView.spacing = 10
            self.heightConstraint.constant = 40
        default:
            print("Anything But Portrait")
        }
        
        self.topSearchContainerStackView.layoutIfNeeded()
        self.galleryCollectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - Extensions TextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        query = textField.text ?? ""
        vm.fetch(maker: selectedArtist, query: query)
    }
}
