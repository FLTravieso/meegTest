//
//  meegStickersVC.swift
//  meegTest
//
//  Created by Frank Travieso on 9/5/17.
//  Copyright © 2017 frank. All rights reserved.
//

import Foundation
import Messages

@available(iOSApplicationExtension 10.0, *)
class meeGStickersVC: MSStickerBrowserViewController{

    var stickers:[MSSticker]!
    var emojis:[URL]!
    var myArray:[UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emojis = [URL]()
        self.myArray = [UIImage]()
        self.stickers = [MSSticker]()
        
        self.getEmojis()
        
        self.stickers = loadMeegs()
    }
    
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        
        return self.stickers.count
        
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        
        return self.stickers[index]
        
    }
    
    private func loadMeegs() -> [MSSticker]{
    
        var stickers = [MSSticker]()
        
        emojis.forEach{
            
            
           let sticker = try! MSSticker(contentsOfFileURL: $0, localizedDescription: "emoji")
            
            stickers.append(sticker)
            
        }
        
        return stickers
        
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

}
