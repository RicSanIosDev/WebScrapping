//
//  SongsFactory.swift
//  06-WebScrapping
//
//  Created by Ricardo Sanchez on 7/7/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class SongsFactory {
    var songs = [Song]()
    
    var songsUrl : String
    
    var completedSongs = 0
    
    var totalDownLoadedSongs = 0
    
    var imageDownloaded = false
    
    init(songsUrl : String) {
        self.songsUrl = songsUrl
        scrappingURL()
    }
    
    func scrappingURL() {
        AF.request(self.songsUrl).responseString { (response) in
            if let htmlString = response.value {
                self.parseHTML(html: htmlString)
            }
        }
    }
    
    func parseHTML(html : String) {
        do {
            
            let doc = try Kanna.HTML(html: html, encoding: String.Encoding.utf8)
            
            
            for div in doc.css("div"){
                if(div["class"] == "song-name-wrapper"){
                    var title = ""
                    var author = ""
                    var url : String = ""
                    for div2 in div.css("div"){
                        
                        if(div2["class"] == "song-name typography-label"){
                            title = div2.text!
                        }
                        
                        if(div2["class"] == "by-line typography-caption"){
                            for a in div2.css("a"){
                                if(a["class"] == "dt-link-to"){
                                    url = a["href"]!
                                    url = self.parseUrl(url: url)
                                    author = a.text!
                                }
                            }
                            
                        }
                        
                     }
                    let song = Song(title: title,author: author, url: url)
                    self.songs.append(song)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("SongsUpdated"), object: nil)
                }
            }
            self.downloadStaticDataCompleted()
        }catch {
            print(error)
        }
    }
    
    func downloadStaticDataCompleted() {
        self.totalDownLoadedSongs = 10
        for i in 0..<self.totalDownLoadedSongs{
            DispatchQueue.main.async {
                self.getImageForSong(self.songs[i])
            }
         }
    }
    
    func getImageForSong(_ song: Song) {
        AF.request(song.url).responseString { (response) in
            
            if let htmlString = response.value {
                
                self.parseImageForHTML(htmlString: htmlString, forSong: song.uuid)
                
            }
        }
    }
    
    func parseImageForHTML(htmlString: String, forSong id: String) {
        
        do{
            let doc = try! Kanna.HTML(html: htmlString, encoding: String.Encoding.utf8)
            for img in doc.css("img"){
                for song in self.songs{
                    if song.uuid == id{
                        song.imgUrl =  img["srcset"]!
                        self.imageDownloaded = true
                        NotificationCenter.default.post(name: NSNotification.Name("SongsUpdated"), object: nil)
                        //self.checkCompletionStatus(forSong: id)
                         break
                    }
                }
                break
            }
        } catch{
            print(error)
        }
        
    }
    
    func parseUrl(url : String) -> String{
        var texto = url
        let chararcterSet = CharacterSet.whitespaces
        let components = texto.components(separatedBy: chararcterSet)
        let words = components.filter { word  in
            !word.isEmpty
        }
        print(words.count)
        return words[0]
    }
    
//    func checkCompletionStatus(forSong id : String) {
//        self.completedSongs += 1
//        print("Estado de completacion : \(self.completedSongs) / \(self.songs.count)")
//    }
}
