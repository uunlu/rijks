//
//  Label.swift
//  Label
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

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
