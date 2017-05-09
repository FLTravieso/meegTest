//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by Frank Travieso on 2/5/17.
//  Copyright © 2017 frank. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var nextKeyboardButton: UIButton!
    var emojis = [URL]()
    var myArray = [UIImage]()
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        print("le")
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("epa")
        
        getEmojis()
        setEmojis()
        //print(myArray.count)
        
//        let imageTest = UIImageView()
//        
//        imageTest.image = myArray[0]
//        imageTest.sizeToFit()
//        imageTest.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.view.addSubview(imageTest)
        let lBundle = Bundle(for: type(of: self))
        let lCellNib = UINib(nibName: "KeyboardKeyCollectionViewCell", bundle: lBundle)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: 20, height: 20)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        
        print(layout.itemSize)
        
        let mCollectionView: UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        mCollectionView.isPagingEnabled = true
        mCollectionView.contentOffset.x = 0.0
        
        mCollectionView.dataSource = self
        mCollectionView.delegate = self
        
        mCollectionView.register(lCellNib, forCellWithReuseIdentifier: "Cell")
        
        mCollectionView.sizeToFit()
        mCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mCollectionView)
        
        mCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        mCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        //self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.blue
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    
    func getEmojis() {
        
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.frank.meegTest")?.appendingPathComponent("emojis")
        do {
            
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsDirectory!, includingPropertiesForKeys: nil, options: [])
            
            self.emojis = directoryContents
            
        } catch  {
            
        }
        
    }
    
    func setEmojis(){
    
        emojis.forEach{
            

                myArray.append(UIImage(contentsOfFile: $0.path)!)
            
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return myArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! KeyboardKeyCollectionViewCell
        cell.emoji.image = myArray[indexPath.row]
        return cell
    }
    
}

class KeyboardKeyCollectionViewCell: UICollectionViewCell {
    var emoji: UIImageView!
}
