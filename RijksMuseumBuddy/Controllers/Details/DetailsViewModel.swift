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
    
    func fetch(id: String){
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
            print(resource.text)
            print("invalid model")
            // TODO: Handle error on UI
            return
        }
        
        //print(result)
        transformData(result)
    }
}

struct ArtObjectDetailsDTO {
    let id: String
    let title: String
    let desciption: String
    let imageLink: String
}
