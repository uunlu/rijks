//
//  Classification.swift
//  Classification
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

// MARK: - Classification
struct Classification: Codable {
    let iconClassIdentifier, iconClassDescription: [String]
    let motifs, events: [String]
    let periods, places: [String]
    let people: [String]
    let objectNumbers: [String]
}
