//
//  DetailsViewController.swift
//  DetailsViewController
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    // MARK: - Variables
    var id: String?
    var vm = DetailsViewModel()
    private var bag: AnyCancellable?
    
    // MARK: - Outlets
    
    @IBOutlet weak var artTitle: UILabel!
    @IBOutlet weak var artDescription: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vm.fetch(id: id!)
        bag = vm.$model
            .sink { value in
                print(value)
                self.updateUI(value)
            }
          //  .store(in: &bag)
    }
    
//    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//         self.view.setNeedsUpdateConstraints()
//    }
    
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
        
        guard let imageURL = URL(string: value.imageLink) else { return }
        let imageLoader = ImageLoader()
        imageLoader.download(url: imageURL) { image in
            DispatchQueue.main.async {
                self.mainImageView.image = image
            }
        }
    }
}
