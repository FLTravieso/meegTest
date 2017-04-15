//
//  PrincipalVC.swift
//  meegTest
//
//  Created by Frank Travieso on 14/4/17.
//  Copyright © 2017 frank. All rights reserved.
//

import UIKit

class PrincipalVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
     var myArray = [#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "SaveBtA")]

    var emojis = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEmojis()
        
        emojis.forEach{
        
            
            if let last = $0.lastPathComponent.characters.first, let value = Int(String(last)) {
                print(value)
                myArray[value] =  UIImage(contentsOfFile: $0.path)!
            
            }
            
        }
        

        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath as IndexPath) as! EmojiCell
        
        cell.emoji.image = myArray[indexPath.row]
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        goToCamera(indexPath.row)
        
    }
    
    func goToCamera(_ index:Int){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let goToCamera = storyBoard.instantiateViewController(withIdentifier: "VC") as! ViewController
        
        goToCamera.index = index
        
        self.present(goToCamera, animated:true, completion:nil)
        
    }
    
    func getEmojis() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        
        let documentsDirectory = paths[0]
        do {
            
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            
            self.emojis = directoryContents
            
        } catch  {
            
        }

    }

}


