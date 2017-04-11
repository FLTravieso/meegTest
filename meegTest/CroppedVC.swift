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
    override func viewDidLoad() {
        super.viewDidLoad()

        if let availableImage = takenPhoto {
            
            croppedImage.image = availableImage
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
