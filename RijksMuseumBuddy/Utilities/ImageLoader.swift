//
//  ImageLoader.swift
//  ImageLoader
//
//  Created by Ugur Unlu on 8/28/21.
//

import Foundation
import UIKit

final class ImageLoader: NSObject {
    var cache: NSCache<NSString, UIImage>
    private var downloadTask: URLSessionDataTask?
    
    init(cache: NSCache<NSString, UIImage> = NSCache()) {
        self.cache = cache
    }
    
    func download(url: URL, completion: @escaping ((UIImage?) -> (Void))) {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        }
        
        downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            completion(image)
        }
        downloadTask?.resume()
    }
    
    func cancel() {
        downloadTask?.cancel()
    }
}
