//
//  ArtCell.swift
//  ArtCell
//
//  Created by Ugur Unlu on 8/27/21.
//

import UIKit

class ArtCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var longTitle: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 15
        backgroundColor = .white
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    var viewModel: ArtDTO? {
        didSet{
            title.text = viewModel?.title
            longTitle.text = viewModel?.longTitle
            
            guard let imageLink = viewModel?.imageLink, let imageURL = URL(string: imageLink) else {
                return
            }
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 15
            guard let imageLoader = viewModel?.imageLoader else { return }
            imageLoader.download(url: imageURL, completion: { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
        }
    }
}
