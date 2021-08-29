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

// MARK: - Acquisition
struct Acquisition: Codable {
    let method, date: String?
    let creditLine: String?
}

// MARK: - Classification
struct Classification: Codable {
    let iconClassIdentifier, iconClassDescription: [String]
    let motifs, events: [String]
    let periods, places: [String]
    let people: [String]
    let objectNumbers: [String]
}

// MARK: - Color
struct Color: Codable {
    let percentage: Int
    let hex: String
}

// MARK: - ColorsWithNormalization
struct ColorsWithNormalization: Codable {
    let originalHex, normalizedHex: String
}

// MARK: - Dating
struct Dating: Codable {
    let presentingDate: String
    let sortingDate, period, yearEarly, yearLate: Int
}

// MARK: - Dimension
struct Dimension: Codable {
    let unit, type: String?
    let part: String?
    let value: String
}

// MARK: - Label
struct Label: Codable {
    let title, makerLine, labelDescription, notes: String?
    let date: String?

    enum CodingKeys: String, CodingKey {
        case title, makerLine
        case labelDescription = "description"
        case notes, date
    }
}

// MARK: - Links
struct LinkDetails: Codable {
    let search: String
}

// MARK: - PrincipalMaker
struct PrincipalMaker: Codable {
    let name, unFixedName, placeOfBirth, dateOfBirth: String?
    let dateOfBirthPrecision: String?
    let dateOfDeath: String?
    let dateOfDeathPrecision: String?
    let placeOfDeath: String?
    let occupation, roles: [String]
    let nationality, biography: String?
    let productionPlaces: [String]
    let qualification: String?
}

// MARK: - WebImage
struct WebImage: Codable {
    let guid: String
    let offsetPercentageX, offsetPercentageY, width, height: Int
    let url: String
}

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

// MARK: - AdlibOverrides
struct AdlibOverrides: Codable {
    let titel, maker, etiketText: String?
}

// MARK: - Maker
struct Maker: Codable {
    let name, unFixedName: String
    let placeOfBirth, dateOfBirth: String?
    let dateOfBirthPrecision: String?
    let dateOfDeath: String?
    let dateOfDeathPrecision: String?
    let placeOfDeath: String?
    let occupation, roles: [String]
    let nationality, biography: String?
    let productionPlaces: [String]
    let qualification: String?
}

