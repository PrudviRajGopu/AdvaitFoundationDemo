//
//  ImageCacheManger.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 05/05/24.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let memoryCache = NSCache<NSString,UIImage>()
    private let fileManager = FileManager.default
    private lazy var cacheDirectoryURL:URL = {
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent("ImageCache")
    }()
    
    private init() {
        createCacheDirectory()
       
    }
    private func createCacheDirectory() {
        do {
            try fileManager.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating cache directory:", error.localizedDescription)
            
        }
    }
    
    func cacheImageInMemory(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        print("cacheImageInMemory=\(key)")
    }
    func getCachedImageFromMemory(forKey key: String) -> UIImage? {
        return memoryCache.object(forKey: key as NSString)
    }
    
    func cacheImageOnDisk(_ image: UIImage, withFileName fileName: String) {

        let fileURL = cacheDirectoryURL.appendingPathComponent(fileName)
        print("cacheDirectoryURL =\(cacheDirectoryURL)")

        print("fileURL =\(fileURL)")
        guard let data = image.pngData() else {
            print("Error converting image to PNG data.")

            return
        }
                print("withFileName=\(fileName)",data)
        do {
            
            try data.write(to: fileURL)
            print("Image saved to disk:", fileURL.absoluteString)
            
            
        } catch {
        print("Error caching image to disk:", error.localizedDescription)
        
        }
       
    }
        
    
    func getCachedImageFromDisk(withFileName fileName: String) -> UIImage? {
            let fileURL = cacheDirectoryURL.appendingPathComponent(fileName)
            guard let imageData = try? Data(contentsOf: fileURL) else { return nil }
            return UIImage(data: imageData)

    }
    
    

    
}
