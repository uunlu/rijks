//
//  SearchCell.swift
//  SearchCell
//
//  Created by Ugur Unlu on 8/28/21.
//

import UIKit

class SearchCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    static let identifier = "SearchCell"
    
    var viewModel: SearchCellViewModel? {
        didSet {
            title.text = viewModel?.title
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = 5
        backgroundColor = .darkGray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
