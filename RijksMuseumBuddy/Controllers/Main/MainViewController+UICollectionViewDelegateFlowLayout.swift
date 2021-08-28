//
//  MainViewController+UICollectionViewDelegateFlowLayout.swift
//  MainViewController+UICollectionViewDelegateFlowLayout
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth: CGFloat = UIScreen.main.bounds.width/2
        if UIScreen.main.bounds.width > 500 {
            cellWidth = UIScreen.main.bounds.width/4
        }
        return CGSize(width: cellWidth - 5, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
