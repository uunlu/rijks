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
    private var bag: AnyCancellable?
    
    // MARK: - Outlets
    @IBOutlet weak var artTitle: UILabel!
    @IBOutlet weak var artDescription: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.fetch(id: id!)
        bag = vm.$model
            .sink { value in
                self.updateUI(value)
            }
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.view.setNeedsUpdateConstraints()
    }
    
}

// MARK: - Extensions | Helpers
extension DetailsViewController {
    func updateUI(_ value: ArtObjectDetailsDTO?){
        guard let value = value else { return }
        artTitle.text = value.title
        artDescription.text = value.desciption
        
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
}
