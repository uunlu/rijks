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
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    init(cache: NSCache<NSString, UIImage> = NSCache()) {
        self.cache = cache
    }
    
    @discardableResult
    func download(url: URL, completion: @escaping ((UIImage?) -> (Void))) -> UUID? {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        }
        
        let uuid = UUID()
        
        downloadTask = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            defer {self.runningRequests.removeValue(forKey: uuid) }
            guard nil == error else {
                print("\(error!.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print(url)
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: url.absoluteString as NSString)
            completion(image)
        }
        downloadTask?.resume()
        runningRequests[uuid] = downloadTask
        
        return uuid
    }
    
    func cancel() {
        downloadTask?.cancel()
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
