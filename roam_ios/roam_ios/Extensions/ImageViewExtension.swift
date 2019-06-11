//
//  ImageViewExtension.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 09/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        //self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
    
    func downloadImageUsingCache(withFIRStorageRef ref : StorageReference , imageName : String) {
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: imageName as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                if let image = UIImage(data: data!){
                    imageCache.setObject(image, forKey: imageName as NSString)
                    self.image = image
                }
            }
        }
        
        
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.7, offSet: CGSize, radius: CGFloat , scale: Bool = true) {
        
        //self.layer.masksToBounds = true
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        //self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 35.0).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
