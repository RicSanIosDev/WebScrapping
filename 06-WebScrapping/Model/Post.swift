//
//  Post.swift
//  06-WebScrapping
//
//  Created by Ricardo Sanchez on 7/8/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import Foundation

class Post {
    
    let uuid : String
    var title : String
    var resum : String
    var url : String
    var imgUrl : String
    
    init(title : String,resum : String,url : String, imgUrl : String) {
           
           self.uuid = UUID().uuidString
           self.title = title
           self.resum = resum
           self.url = url
           self.imgUrl = imgUrl
       }
    
}
