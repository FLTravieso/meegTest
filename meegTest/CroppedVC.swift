//
//  CroppedVC.swift
//  meegTest
//
//  Created by Frank Travieso on 11/4/17.
//  Copyright © 2017 frank. All rights reserved.
//

import UIKit

class CroppedVC: UIViewController {

    @IBOutlet weak var croppedImage: UIImageView!
    
    var takenPhoto: UIImage?
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(getDocumentsDirectory())
        if let availableImage = takenPhoto {
            
            croppedImage.image = availableImage

            
        }
    }

    @IBAction func saveEmoji(_ sender: Any) {
        
        if let image = takenPhoto {
            if let data = UIImagePNGRepresentation(image) {
                let filename = getDocumentsDirectory().appendingPathComponent("\(index).png")
                try? data.write(to: filename)
            }
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let goToPrincipal = storyBoard.instantiateViewController(withIdentifier: "PrincipalVC") as! PrincipalVC
        
        
        self.present(goToPrincipal, animated:true, completion:nil)
        
    }
    
    func getDocumentsDirectory() -> URL {
        
        
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.frank.meegTest")?.appendingPathComponent("emojis")
        
        do {
            
            try FileManager.default.createDirectory(atPath: (documentsDirectory?.path)!, withIntermediateDirectories: true, attributes: nil)
            
        } catch {
            
        }
        
        return documentsDirectory!
    }

}
