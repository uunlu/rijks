//
//  DetailsViewController.swift
//  DetailsViewController
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit
import Combine

final class DetailsViewController: UIViewController {
    // MARK: - Variables
    var id: String?
    private var vm = DetailsViewModel()
    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Outlets
    @IBOutlet private weak var artTitleLabel: UILabel!
    @IBOutlet private weak var artDescriptionLabel: UILabel!
    @IBOutlet private weak var mainImageView: UIImageView!
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subcribeToPublishers()
        vm.fetch(id: id)
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.view.setNeedsUpdateConstraints()
    }
}

// MARK: - Extensions | Helpers
extension DetailsViewController {
    fileprivate func subcribeToPublishers() {
        vm.$model
            .sink { value in
                self.updateUI(value)
            }
            .store(in: &bag)
        vm.$hasError
            .sink { value in
                if value {
                    self.displayError()
                }
            }
            .store(in: &bag)
    }
    func updateUI(_ value: ArtObjectDetailsDTO?){
        guard let value = value else { return }
        artTitleLabel.text = value.title
        artDescriptionLabel.text = value.desciption
        
        guard let imageURL = URL(string: value.imageLink) else {
            mainImageView.image = UIImage(named: "Default")
            return
        }
        let imageLoader = ImageLoader()
        imageLoader.download(url: imageURL) { image in
            DispatchQueue.main.async {
                self.mainImageView.image = image
            }
        }
    }
    
    func displayError() {
        let errorMessage = "Collection cannot be displayed"
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
}
