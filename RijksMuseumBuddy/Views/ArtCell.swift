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
    @IBOutlet weak var longTitleHeightConstraint: NSLayoutConstraint!
    static let identifier = "ArtCell"
    private let longTitleHeightPortraitModeConstraint: CGFloat = 80
    private var imageDownloadID: UUID?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 15
        backgroundColor = .white
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        guard let id = imageDownloadID else { return }
        viewModel?.imageLoader?.cancelLoad(id)
    }
    
    override func layoutSubviews() {
        if bounds.width > bounds.height {
            longTitleHeightConstraint.constant = 0
        }else {
            longTitleHeightConstraint.constant = longTitleHeightPortraitModeConstraint
        }
    }
    
    var viewModel: ArtDTO? {
        didSet{
            title.text = viewModel?.title
            longTitle.text = viewModel?.longTitle
            
            guard let imageLink = viewModel?.imageLink, let imageURL = URL(string: imageLink) else {
                self.imageView.image = UIImage(named: "Default")
                return
            }
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 15
            loadImage(imageURL: imageURL)
        }
    }
    
    private func loadImage(imageURL: URL) {
        guard let imageLoader = viewModel?.imageLoader else { return }
        // TODO: A retry mechanism with finite number of trials of downloading images should be implemented.
        imageDownloadID = imageLoader.download(url: imageURL, completion: { image in
            if image == nil {
                self.imageView.image = UIImage(named: "Default")
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()+1){
                    imageLoader.cancelLoad(self.imageDownloadID!)
                    self.loadImage(imageURL: imageURL)
                    return
                }
            }
            DispatchQueue.main.async {
                    self.imageView.image = image
            }
        })
    }
}
