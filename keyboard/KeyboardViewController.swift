//
//  KeyboardViewController.swift
//  keyboard
//
//  Created by Frank Travieso on 2/5/17.
//  Copyright © 2017 frank. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionEmojis: UICollectionView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var pager: UIPageControl!
    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var hintButton: UIButton!
    var emojis = [URL]()
    var myArray = [UIImage]()
    var constraint = NSLayoutConstraint()

    let kPressPasteTitleAppearDuration = 0.5
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        setKeyboardHeight()
        
        setCollectionEmojisLayout()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        setKeyboardHeight()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEmojis()
        setEmojis()
        setNumberOfPages()
        
        self.deleteButton.setTitle("⌫", for: .normal)
        
        hintView.isHidden = true
        configureHintButton()
    }
    
    func setNumberOfPages(){
        
        let pageNumber = Int(ceilf(Float(myArray.count)/Float(8)))
        
        self.pager.numberOfPages = pageNumber
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pager.currentPage = Int(pageNumber)
        
        print(pageNumber)
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.emoji.image = myArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("seleccionaste el emoji \(indexPath.row)")
        
        let image = myArray[indexPath.row]
        
        let pb = UIPasteboard.general
        
        let pngType = UIPasteboardTypeListImage[0] as! String
        
        pb.image = image
        
        pb.setData(UIImagePNGRepresentation(image)!, forPasteboardType: pngType)
        
        showHint()
    }
    
    
    @IBAction func next(_ sender: Any) {

        self.advanceToNextInputMode()
        
    }
    
    
    @IBAction func deleteEmoji(_ sender: Any) {
        
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.deleteBackward()
    }

    
    
    func setCollectionEmojisLayout(){

        
        print(self.view.bounds.width/4)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        self.collectionEmojis!.collectionViewLayout = layout
        
        collectionEmojis.isPagingEnabled = true
        collectionEmojis.contentOffset.x = 0.0
        
    }
    
    func setKeyboardHeight () {
        
        let screenSize = UIScreen.main.bounds.size
        let screenH = screenSize.height
        
        self.view.removeConstraint(constraint)
        
        if screenH >= 414 {
            
            //for iPhone portrait AND iPhone Plus landscape or portrait
            self.constraint = NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 220.0)
            self.view.addConstraint(self.constraint)
            
            
        } else {
            //for iPhone landscape
            self.constraint = NSLayoutConstraint(item: self.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 140.0)
            self.view.addConstraint(self.constraint)

        }
        
    }
    
    fileprivate func configureHintButton() {
        hintView.backgroundColor = UIColor(red: 32/255.0, green: 59/255.0, blue: 104/255.0, alpha: 0.7)
        
        let fontSize:CGFloat = 16.0
        let button = UIButton(frame: CGRect(x:0, y: 0, width: 140, height: 100))
        hintButton = button
        let font1 = UIFont(name: "Arial", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        let font2 = UIFont(name: "Arial", size:fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        let color = UIColor.white
        
        let myNormalAttributedTitle = NSMutableAttributedString(string: "Copied to the clipboard. Now tap and\n",
                                                                attributes: [NSFontAttributeName : font1, NSForegroundColorAttributeName: color ])
        
        let myBoldAttributedTitle = NSAttributedString(string: " paste ",
                                                       attributes: [NSFontAttributeName : font2, NSForegroundColorAttributeName: color])
        let myLastAttributedTitle = NSAttributedString(string: " into the message field",
                                                       attributes: [NSFontAttributeName : font1, NSForegroundColorAttributeName: color])
        myNormalAttributedTitle.append(myBoldAttributedTitle)
        myNormalAttributedTitle.append(myLastAttributedTitle)
        hintButton.translatesAutoresizingMaskIntoConstraints = false
        hintButton.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        
        
        hintButton.layer.cornerRadius = 10
        hintButton.titleLabel!.numberOfLines = 2
        hintButton.titleLabel!.lineBreakMode = .byWordWrapping;
        hintButton.titleLabel!.textAlignment = .center;
        
        
        hintView.addSubview(hintButton)
        
        let centerX = NSLayoutConstraint(item: hintView, attribute: .centerX, relatedBy: .equal, toItem: hintButton, attribute: .centerX, multiplier: 1, constant: 0)
        
        let centerY = NSLayoutConstraint(item: hintView, attribute: .centerY, relatedBy: .equal, toItem: hintButton, attribute: .centerY, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([centerX, centerY])
    }
    
    fileprivate func hideHint(){
        self.hintView.isHidden = true
    }
    
    fileprivate func showHint(){
        self.hintView.isHidden = false
        self.hintView.alpha = 0
        UIView.animate(withDuration: kPressPasteTitleAppearDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.hintView!.alpha = 1
        }, completion: { (Bool) -> () in
            UIView.animate(withDuration: self.kPressPasteTitleAppearDuration, delay: self.kPressPasteTitleAppearDuration, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.hintView!.alpha = 0
            }, completion: nil)
        })
    }
    
}
