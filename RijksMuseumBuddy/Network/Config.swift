//
//  Config.swift
//  Config
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation

struct Config {
    static let baseURL = "https://www.rijksmuseum.nl/api/"
    static let apiKey = "dk6t7TSv"
    static var language: String {
        guard let currentLanguageCode = Locale.current.languageCode else{
            return "en"
        }
        return currentLanguageCode == "nl" ?  "nl" : "en"
    }
}
