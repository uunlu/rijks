//
//  Dimension.swift
//  Dimension
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

// MARK: - Dimension
struct Dimension: Codable {
    let unit, type: String?
    let part: String?
    let value: String
}
