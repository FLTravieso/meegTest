//
//  Tutorial1VC.swift
//  meegTest
//
//  Created by Frank Travieso on 29/5/17.
//  Copyright © 2017 frank. All rights reserved.
//

import UIKit

class Tutorial1VC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var tutorialCollection: UICollectionView!
    
    var myArray = [#imageLiteral(resourceName: "CancelBtA"),#imageLiteral(resourceName: "SaveBtA"),#imageLiteral(resourceName: "CameraBtA")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionTutorialLayout()
        print("aca")
        
    }
    
    func setCollectionTutorialLayout(){
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.bounds.width, height: self.tutorialCollection.bounds.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        self.tutorialCollection!.collectionViewLayout = layout
        
        tutorialCollection.isPagingEnabled = true
        tutorialCollection.contentOffset.x = 0.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stepCell", for: indexPath as IndexPath) as! StepCell
        
        cell.step.image = myArray[indexPath.row]
        
        
        return cell
    }
    

 
}

    

