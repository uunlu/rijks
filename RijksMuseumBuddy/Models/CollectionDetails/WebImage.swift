//
//  WebImage.swift
//  WebImage
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

// MARK: - WebImage
struct WebImage: Codable {
    let guid: String
    let offsetPercentageX, offsetPercentageY, width, height: Int
    let url: String
}
