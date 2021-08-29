//
//  DetailsViewModel.swift
//  DetailsViewModel
//
//  Created by Ugur Unlu on 8/29/21.
//

import Foundation
import Combine
import Siesta

class DetailsViewModel: ObservableObject {
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
        model = ArtObjectDetailsDTO(id: data.artObject.id, title: data.artObject.title, desciption: data.artObject.artObjectDescription ?? "No Description",
                                    imageLink: data.artObject.webImage.url)
    }
}

extension DetailsViewModel: ResourceObserver {
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        guard let result: CollectionDetails = resource.typedContent() else {
            print(resource.text)
            print("invalid model")
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
