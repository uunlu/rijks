//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Ugur Unlu on 8/28/21.
//

import XCTest

class NetworkTests: XCTestCase {

    func testShouldBeEqual_LocalLanguage_ConfigLanguage() throws {
        let language = Locale.current.languageCode!
        XCTAssertEqual(language, Config.language)
    }
    
    func testShouldBeLanguage_Dutch_If_LocaleIsDutch() {
        let language = "nl"
        XCTAssertEqual(language, Config.language)
    }
    
    func testShouldMatch_ResourceUrlEndPoints() throws {
        var resource = API.shared.search("Rembrandt van Rijn")
        
        XCTAssertEqual(resource.url.lastPathComponent, "collection")
        XCTAssertEqual(resource.url.relativeString, "https://www.rijksmuseum.nl/api/en/collection?involvedMaker=Rembrandt%20van%20Rijn&key=dk6t7TSv&p=1&ps=10")
        
        resource = API.shared.search("Rembrandt van Rijn", page: 2)
        XCTAssertEqual(resource.url.relativeString, "https://www.rijksmuseum.nl/api/en/collection?involvedMaker=Rembrandt%20van%20Rijn&key=dk6t7TSv&p=2&ps=10")
    }
    
    func testGalleryViewModelCurrentPage() {
        let resource = API.shared.search("", query: "gold")
        let vm = GalleryViewModel(with: resource)
        XCTAssertEqual(vm.currentPage, 1)
        let expectation = XCTestExpectation(description: "Network Wait Expectation")
        vm.fetch(maker: "", query: "gold")
        _=XCTWaiter.wait(for: [expectation], timeout: 6.0)
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            XCTAssertEqual(vm.currentPage, 2)
            expectation.fulfill()
        }
    }
}
