//
//  ArtObjectDetails.swift
//  ArtObjectDetails
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

// MARK: - ArtObject
struct ArtObjectDetails: Codable {
    let links: LinkDetails
    let id, priref, objectNumber, language: String
    let title: String
    let copyrightHolder: String?
    let webImage: WebImage?
    let colors: [Color]
    let colorsWithNormalization: [ColorsWithNormalization]
    let normalizedColors, normalized32Colors: [Color]
    let titles: [String]
    let artObjectDescription: String?
    let labelText: String?
    let objectTypes, objectCollection: [String]?
    let makers: [Maker]?
    let principalMakers: [PrincipalMaker]?
    let plaqueDescriptionDutch, plaqueDescriptionEnglish, principalMaker: String?
    let artistRole: String?
    let associations: [String]
    let acquisition: Acquisition
    let exhibitions: [String]
    let materials: [String]
    let techniques: [String]
    let productionPlaces: [String]?
    let dating: Dating?
    let classification: Classification?
    let hasImage: Bool?
    let historicalPersons, inscriptions: [String]
    let documentation: [String]?
    let catRefRPK: [String]?
    let principalOrFirstMaker: String?
    let dimensions: [Dimension]
    let physicalProperties: [String]
    let physicalMedium, longTitle, subTitle, scLabelLine: String?
    let label: Label?
    let showImage: Bool?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case links, id, priref, objectNumber, language, title, copyrightHolder, webImage, colors, colorsWithNormalization, normalizedColors, normalized32Colors, titles
        case artObjectDescription = "description"
        case labelText, objectTypes, objectCollection, makers, principalMakers, plaqueDescriptionDutch, plaqueDescriptionEnglish, principalMaker, artistRole, associations, acquisition, exhibitions, materials, techniques, productionPlaces, dating, classification, hasImage, historicalPersons, inscriptions, documentation, catRefRPK, principalOrFirstMaker, dimensions, physicalProperties, physicalMedium, longTitle, subTitle, scLabelLine, label, showImage, location
    }
}
