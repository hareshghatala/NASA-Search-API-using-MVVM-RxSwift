//
//  UIImageView+WebImage.swift
//  NASA
//
//  Created by Haresh Ghatala on 13/07/21.
//  Copyright © 2021 Haresh Ghatala. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {

    let cache = NSCache<NSString, UIImage>()
    
    public static let shared = ImageCache()
    private init() {}
    
}

extension UIImageView {
    
    func load(urlStr: String, placeholder: Bool = true) {
        
        if let cachedImage = ImageCache.shared.cache.object(forKey: urlStr as NSString) {
            self.image = cachedImage
            return
        }
        
        self.image = placeholder ? UIImage(named: imgNamePlaceholder) : UIImage()
        
        guard let url = URL(string: urlStr) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    ImageCache.shared.cache.setObject(image, forKey: urlStr as NSString)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
        
    }
    
}
