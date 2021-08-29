//
//  ArtObjectPage.swift
//  ArtObjectPage
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

// MARK: - ArtObjectPage
struct ArtObjectPage: Codable {
    let id: String
    let similarPages: [String]
    let lang, objectNumber: String
    let tags: [String]
    let plaqueDescription: String?
    let audioFile1, audioFileLabel1, audioFileLabel2: String?
    let createdOn, updatedOn: String?
    let adlibOverrides: AdlibOverrides?
}
