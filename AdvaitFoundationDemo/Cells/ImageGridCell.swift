//
//  ImageGridCell.swift
//  AdvaitFoundationDemo
//
//  Created by Gopu on 04/05/24.
//

import UIKit


protocol ImageCellDelegate: AnyObject {
    func showAlert(title: String, message: String)
    func onTappingImg(img:UIImage)
}
class ImageGridCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    private let imageCache = NSCache<NSString, UIImage>() // NSCache for in-memory caching
    weak var delegate:ImageCellDelegate?
    var imageURL: URL?
    var action: (() -> Void)?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateCell(cellPath:ImageGridResponseElement) {
        let image_URL = cellPath.thumbnail.domain + "/" + cellPath.thumbnail.basePath + "/0/" + cellPath.thumbnail.key
        let fileName = cellPath.thumbnail.id + ".jpg"
        
        if let imageURL = URL(string: image_URL) {
            print("imageURL",imageURL.absoluteString)
            self.imageURL = imageURL

            if let cachedImage = ImageCacheManager.shared.getCachedImageFromMemory(forKey: imageURL.absoluteString) {
                self.imgView.image = cachedImage
                print("getCachedImageFromMemory",imageURL)

            } else {
                
               
                    
                if let cachedImage = ImageCacheManager.shared.getCachedImageFromDisk(withFileName: fileName) {
                    self.imgView.image = cachedImage
                    print("getCachedImageFromDisk",imageURL)

                          
                    ImageCacheManager.shared.cacheImageInMemory(cachedImage, forKey: imageURL.absoluteString)
                    
                } else {
                      
                    DispatchQueue.global().async {
                         
                        if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                                 print("Dispatchimage",image)
                            ImageCacheManager.shared.cacheImageInMemory(image, forKey: imageURL.absoluteString)
                            ImageCacheManager.shared.cacheImageOnDisk(image, withFileName: fileName)
                            print("DispatchQueue",imageURL)

                            
                            DispatchQueue.main.async {

                                if self.imageURL == imageURL {
                                    self.imgView.image = image

                                }
                                
                            }
                            
                        } else {
                            self.delegate?.showAlert(title: "Alert", message:  "Error loading image" )

                        }
                        
                    }
                    
                }
                
            }
        } else {
            delegate?.showAlert(title: "Alert", message: "unable to load the Image")
        }
            
           
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
                
        imgView.addGestureRecognizer(tapGesture)
        
        imgView.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped() {
        // Notify the delegate to show the alert
        delegate?.onTappingImg(img: self.imgView.image!)
//        action?()

    }
    
}
