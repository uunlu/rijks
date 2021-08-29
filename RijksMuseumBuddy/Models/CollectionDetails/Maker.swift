//
//  Maker.swift
//  Maker
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

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
