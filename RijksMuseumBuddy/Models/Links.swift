//
//  Links.swift
//  Links
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation

// MARK: - Links
struct Links: Codable {
    let linksSelf, web: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case web
    }
}
