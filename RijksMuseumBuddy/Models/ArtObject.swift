//
//  ArtObject.swift
//  ArtObject
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation

// MARK: - ArtObject
struct ArtObject: Codable {
    let links: Links
    let id, objectNumber, title: String
    let hasImage: Bool
    let principalOrFirstMaker: String
    let longTitle: String
    let showImage, permitDownload: Bool
    let webImage, headerImage: Image?
    let productionPlaces: [String]
}
