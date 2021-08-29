//
//  GalleryViewModel.swift
//  GalleryViewModel
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import Siesta
import Combine

final class GalleryViewModel: ObservableObject {
    private(set) var currentPage: Int = 1
    private(set) var collectionsResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            oldValue?.cancelLoadIfUnobserved()
            collectionsResource?.addObserver(self).loadIfNeeded()
        }
    }
    private var lastMaker: String = ""
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
            // TODO: Handle error on UI
            return
        }
        
//        print(result)
        self.items.removeAll()
        self.items.append(contentsOf: result.artObjects)
        currentPage += 1
    }
    
    func fetch(maker: String, query: String = "") {
        if lastMaker != maker || lastQuery != query {
            currentPage = 1
            lastMaker = maker
            lastQuery = query
            items.removeAll()
        }
        collectionsResource = API.shared.search(maker, query: query, page: currentPage)
    }
}


protocol Fetchable {
    var currentPage: Int { get set }
    var lastQuery: String { get set }
    func fetch(searchQuery: String)
}
