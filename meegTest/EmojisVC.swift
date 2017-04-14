
import UIKit

class EmojisVC: UIViewController {

    @IBOutlet weak var emoji: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = getDocumentsDirectory().appendingPathComponent("copy.png")
        
            if let image  = UIImage(contentsOfFile: imageURL.path){
            
                emoji.image = image
            
            }
        
        
        
        
        
       
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        let documentsDirectory = paths[0]
        do {
            
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
        } catch  {
            
        }
        return documentsDirectory
    }
    
}
