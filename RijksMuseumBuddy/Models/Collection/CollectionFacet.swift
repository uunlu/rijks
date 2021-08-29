//
//  CollectionFacet.swift
//  CollectionFacet
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation

// MARK: - CollectionFacet
struct CollectionFacet: Codable {
    let facets: [FacetFacet]
    let name: String
    let otherTerms, prettyName: Int
}
