//
//  GalleryViewModel.swift
//  GalleryViewModel
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import Siesta
import Combine

class GalleryViewModel: ObservableObject {
    private(set) var currentPage: Int = 1
    private(set) var collectionsResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            oldValue?.cancelLoadIfUnobserved()
            collectionsResource?.addObserver(self).loadIfNeeded()
        }
    }
    private var lastQuery: String = ""
    @Published var items: [ArtObject] = []
    
    init(with resource: Resource = API.shared.search("", page: 1)){
        collectionsResource = resource
    }
}

extension GalleryViewModel: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let result: Collection = resource.typedContent() else {
            print(resource.text)
            print("invalid model")
            return
        }
        
//        print(result)
        self.items.append(contentsOf: result.artObjects)
        currentPage += 1
    }
    
    func fetch(searchQuery: String) {
        if lastQuery != searchQuery {
            currentPage = 1
            lastQuery = searchQuery
            items.removeAll()
        }
        collectionsResource = API.shared.search(searchQuery, page: currentPage)
    }
}


protocol Fetchable {
    var currentPage: Int { get set }
    var lastQuery: String { get set }
    func fetch(searchQuery: String)
}
