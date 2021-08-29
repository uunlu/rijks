//
//  Dating.swift
//  Dating
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation

// MARK: - Dating
struct Dating: Codable {
    let presentingDate: String
    let sortingDate, period, yearEarly, yearLate: Int
}
