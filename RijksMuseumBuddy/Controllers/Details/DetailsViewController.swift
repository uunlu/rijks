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
    private var initialCenter: CGPoint = .zero
    private var scaleDiff: CGFloat = 0
    // MARK: - Outlets
    @IBOutlet private weak var artTitleLabel: UILabel!
    @IBOutlet private weak var artDescriptionLabel: UILabel!
    @IBOutlet private weak var mainImageView: UIImageView!
    
    @IBOutlet weak var topStackViewToMainImageViewBuittomCostraint: NSLayoutConstraint!
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subcribeToPublishers()
        addGestureRecognizer()
        vm.fetch(id: id)
    }
    
    private func addGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        mainImageView.isUserInteractionEnabled = true
        // Add Swipe Gesture Recognizer
        mainImageView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialCenter = mainImageView.center
        case .changed:
            let translation = sender.translation(in: view)
            guard initialCenter.y - translation.y < 0 else {
                return
            }
            let scaleRatio = min(1.25, 1+abs(initialCenter.y - translation.y)/500)
            
            mainImageView.transform = CGAffineTransform(scaleX: scaleRatio, y: scaleRatio)
            view.layoutIfNeeded()
        default:
            mainImageView.transform = CGAffineTransform.identity
            view.updateConstraintsIfNeeded()
            break
        }
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
