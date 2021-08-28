//
//  API.swift
//  API
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import Siesta

class API: Service {
    static let shared = API()
    private let service = Service(baseURL: "\(Config.baseURL)\(Config.language)", standardTransformers: [.text, .json])

    fileprivate init() {
        #if DEBUG
        // Bare-bones logging of which network calls Siesta makes:
        SiestaLog.Category.enabled = [.network]
        
        // For more info about how Siesta decides whether to make a network call,
        // and which state updates it broadcasts to the app:
        //SiestaLog.Category.enabled = .common
        // For the gory details of what Siesta’s up to:
        //SiestaLog.Category.enabled = .detailed
        // To dump all requests and responses:
        // (Warning: may cause Xcode console overheating)
        //SiestaLog.Category.enabled = .all
        #endif
        
        // –––––– Global configuration ––––––
        let jsonDecoder = JSONDecoder()
        
        service.configure("**") {
               $0.headers["Content-Type"] = "application/json;charset=UTF-8"
               $0.headers["Accept"] = "application/json;charset=UTF-8"
               // Disable default Siesta transformer
               $0.pipeline[.parsing].removeTransformers()
           }
        service.configureTransformer("collection") {
                try jsonDecoder.decode(Collection.self, from: $0.content)
        }
    }
}

extension API {
    func search(_ involvedMaker: String, query: String = "", page: Int = 1, pageSize: Int = 10) -> Resource {
        return service
            .resource("collection")
            .withParam("key", Config.apiKey)
            .withParam("involvedMaker", involvedMaker)
            .withParam("p", "\(page)")
            .withParam("q", "\(query)")
            .withParam("ps", "\(pageSize)")
    }
}
