//
//  UIImageView+.swift
//  APIClient-MVC
//
//  Created by Syunsuke Nakao on 2019/06/13.
//  Copyright © 2019 Syunsuke Nakao. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func setImage(fromUrl: String?) {
        
        guard let urlString = fromUrl else {
            self.image = UIImage(named: "default")
            return
        }
        
        if let cacheImage = UIImageView.imageCache.object(forKey: fromUrl as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        let imageUrl = URL(string: urlString)
        
        DispatchQueue.global().async {
            
            do {
                
                let data = try Data(contentsOf: imageUrl!)
                let image = UIImage(data: data)
                
                UIImageView.imageCache.setObject(image!, forKey: fromUrl as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = image
                }
                
            } catch let error {
                
                print("Error : \(error.localizedDescription)")
                self.image = UIImage(named: "default")
                
            }
            
        }
        
        
    }
    
}
