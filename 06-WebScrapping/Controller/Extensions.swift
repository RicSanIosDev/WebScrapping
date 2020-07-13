//
//  Extensions.swift
//  06-WebScrapping
//
//  Created by Ricardo Sanchez on 7/7/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadedFrom(link : String, contenMode mode : UIView.ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return  }
        downloadedFrom(url: url)
    }
    
    func downloadedFrom( url : URL, contenMode mode : UIView.ContentMode = .scaleAspectFit ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mineType = response?.mimeType, mineType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {return}
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
