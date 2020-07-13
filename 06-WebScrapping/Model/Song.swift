//
//  Song.swift
//  06-WebScrapping
//
//  Created by Ricardo Sanchez on 7/7/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import Foundation


class Song {
    let uuid : String
    var title : String
    var author : String
    var url : String
    var imgUrl : String
    
    init(title : String, author : String, url : String) {
        
        self.uuid = UUID().uuidString
        
        self.title = title
        self.author = author
        self.url = url
        self.imgUrl = ""
    }
    
    init(title : String,author : String,url : String, imgUrl : String) {
           
           self.uuid = UUID().uuidString
           
           self.title = title
           self.author = author
           self.url = url
           self.imgUrl = imgUrl
       }
    
}
