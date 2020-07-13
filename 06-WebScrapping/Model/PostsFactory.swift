//
//  PostsFactory.swift
//  06-WebScrapping
//
//  Created by Ricardo Sanchez on 7/8/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class PostsFactory {
    var post = [Post]()
    
    var potsUrl : String
    
    var completedPost = 0
    
    var totalDownLoadedPosts = 0
    
    var imageDownloaded = false
    
    init(potsUrl : String) {
        self.potsUrl = potsUrl
        scrappingURL()
    }
    
    func scrappingURL() {
        AF.request(self.potsUrl).responseString { (response) in
            if let htmlString = response.value {
                self.parseHTML(html: htmlString)
            }
        }
    }
    
    func parseHTML(html : String) {
        do {
            
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)
            
            for article in doc.css("article"){
                var title = ""
                var url = ""
                var resum = ""
                var imgUrl = ""
                
                for h2 in article.css("h2"){
                    for a in h2.css("a"){
                        title = a.text!
                        url = a["href"]!
                        break
                    }
                    break
                }
                for p in article.css("p"){
                    resum = p.text!
                    break
                }
                for img in article.css("img"){
                    imgUrl = img["src"]!
                }
               
                let post = Post(title: title, resum: resum, url: url, imgUrl: imgUrl)
                self.post.append(post)
                NotificationCenter.default.post(name: NSNotification.Name("PostUpdated"), object: nil)
            }
          
        }catch {
            print(error)
        }
    }
}
