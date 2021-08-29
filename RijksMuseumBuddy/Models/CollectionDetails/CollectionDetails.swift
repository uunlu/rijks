//
//  CollectionDetails.swift
//  CollectionDetails
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

// MARK: - Collection
struct CollectionDetails: Codable {
    let elapsedMilliseconds: Int
    let artObject: ArtObjectDetails
    let artObjectPage: ArtObjectPage
}
