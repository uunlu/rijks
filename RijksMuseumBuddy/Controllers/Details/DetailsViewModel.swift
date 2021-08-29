//
//  DetailsViewModel.swift
//  DetailsViewModel
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation
import Combine
import Siesta

final class DetailsViewModel: ObservableObject {
    private(set) var detailsResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            oldValue?.cancelLoadIfUnobserved()
            detailsResource?.addObserver(self).loadIfNeeded()
        }
    }
    
    @Published private(set) var model: ArtObjectDetailsDTO?
    @Published private(set) var hasError: Bool = false
    
    func fetch(id: String?){
        guard let id = id else { return }
        detailsResource = API.shared.details(id: id)
    }
    
    private func transformData(_ data: CollectionDetails) {
        let artObject = data.artObject
        let description = artObject.artObjectDescription ?? "No Description"
        let imageLink = artObject.webImage?.url ?? ""
        
        model = ArtObjectDetailsDTO(id: artObject.id, title: artObject.title, desciption: description,
                                    imageLink: imageLink)
    }
}

extension DetailsViewModel: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let result: CollectionDetails = resource.typedContent() else {
            print("invalid model")
            if let error = resource.latestError {
                print("--error: \(error.userMessage)")
                self.hasError = true
            }
            return
        }
        self.hasError = false
        transformData(result)
    }
}
