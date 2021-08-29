//
//  Image.swift
//  Image
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let guid: String?
    let offsetPercentageX, offsetPercentageY, width, height: Int?
    let url: String?
}
