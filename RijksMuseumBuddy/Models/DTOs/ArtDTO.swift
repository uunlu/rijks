//
//  ArtDTO.swift
//  ArtDTO
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation

struct ArtDTO: ImageLoadable {
    var imageLoader: ImageLoader?
    let title: String
    let longTitle: String
    let imageLink: String
}
