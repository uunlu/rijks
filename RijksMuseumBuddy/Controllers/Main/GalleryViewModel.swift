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
    @Published private(set) var hasError: Bool = false
    
    init(with resource: Resource = API.shared.search("", page: 1)){
        collectionsResource = resource
    }
}

extension GalleryViewModel: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let result: Collection = resource.typedContent() else {
            print("invalid model")
            // TODO: Handle error on UI
            if let error = resource.latestError {
                print("--error: \(error.userMessage)")
                self.hasError = true
            }
            return
        }
        
        items.removeAll()
        items.append(contentsOf: result.artObjects)
        currentPage += 1
    }
    
    func fetch(maker: String, query: String = "", page: Int? = nil) {
        if let page = page {
            currentPage = page
        }
        if lastMaker != maker || lastQuery != query {
            currentPage = 1
            lastMaker = maker
            lastQuery = query
        }
        
        collectionsResource = API.shared.search(maker, query: query, page: currentPage)
    }
}
