//
//  ImageLoaderTests.swift
//  ImageLoaderTests
//
//  Created by Ugur Unlu on 8/28/21.
//

import XCTest

class ImageLoaderTests: XCTestCase {
    func testshouldBeLoading_And_CachingImage() {
        let cache = NSCache<NSString, UIImage>()
        let loader = ImageLoader(cache: cache)
        var image: UIImage? = nil
        let firstImageURL = URL(string: "https://lh3.googleusercontent.com/I9oSzKfxHOxXB2GHbHE5byjd5FABgY7XEbAh0U5AJgsVJdCwsVJrtazWekJ7NSW5jPM96gflYIDeAu2wv3-8oXBhsT8=s0")!
        let expectation = XCTestExpectation(description: "Image Loader Check")
        
        loader.download(url: firstImageURL) { img in
            image = img
            expectation.fulfill()
        }
        _=XCTWaiter.wait(for: [expectation], timeout: 5.0)
        
        XCTAssertTrue(image != nil)
        XCTAssertEqual(cache.object(forKey: firstImageURL.absoluteString as NSString), image)
    }
    
    func testShouldBeNilIfImageLoadFails() {
        let loader = ImageLoader()
        var image: UIImage? = nil
        let expectation = XCTestExpectation(description: "Image Loader Check")
        
        loader.download(url: URL(string: "https://www.google.com")!){ img in
            image = img
            expectation.fulfill()
        }
        
        _=XCTWaiter.wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(image)
    }
    
    func testShouldCancelDownloadTaskWithId() {
        let loader = ImageLoader()
        var image: UIImage? = nil
        let imageURL = URL(string: "https://lh3.googleusercontent.com/I9oSzKfxHOxXB2GHbHE5byjd5FABgY7XEbAh0U5AJgsVJdCwsVJrtazWekJ7NSW5jPM96gflYIDeAu2wv3-8oXBhsT8=s0")!
        
        let expectation = XCTestExpectation(description: "Image Download Task Id Check")
        let id = loader.download(url: imageURL) { img in
            image = img
            expectation.fulfill()
        }
        XCTAssertNotNil(id)
        loader.cancelLoad(id!)
        XCTAssertNil(image)
        _=XCTWaiter.wait(for: [expectation], timeout: 5.0)
    }
}
