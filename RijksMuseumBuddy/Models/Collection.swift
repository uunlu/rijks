//
//  Collection.swift
//  Collection
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation

// MARK: - Collection
struct Collection: Codable {
    let elapsedMilliseconds, count: Int
    let countFacets: CountFacets
    let artObjects: [ArtObject]
    let facets: [CollectionFacet]
}
