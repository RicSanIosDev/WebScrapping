//
//  ViewController.swift
//  06-WebScrapping
//
//  Created by Ricardo Sanchez on 7/6/20.
//  Copyright © 2020 Ricardo Sanchez. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UICollectionViewController {

    let urlName = "https://music.apple.com/us/playlist/top-100-global/pl.d25f5d1181894928af76c85c967f8f31?itscg=10000&itsct=mus-0-mus_fam-posn3_stm-apl-avl-200130"
    
    let urlName2 = "http://juangabrielgomila.com/blog"
    
    //var factory : SongsFactory!
    
    var factory2 : PostsFactory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadItemInCollectionView), name: NSNotification.Name("PostUpdated"), object: nil)
        
        //factory = SongsFactory(songsUrl: urlName)
        factory2 = PostsFactory(potsUrl: urlName2)
        
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.factory2.post.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.labelSong.text = factory2.post[indexPath.row].title
        cell.imageViewSong.downloadedFrom(link: factory2.post[indexPath.row].imgUrl)
        cell.labelTextView.text = factory2.post[indexPath.row].resum
       
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: factory2.post[indexPath.row].url){
            UIApplication.shared.open(url, options: [:]) { (success) in
                print("Hemos ido al post \(self.factory2.post[indexPath.row].title)")
            }
        }
    }
    
  @objc func reloadItemInCollectionView() {
        self.collectionView.reloadData()
    }
}


