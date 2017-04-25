import Foundation
import UIKit

class Cropper{
    
    static let sharedInstance = Cropper()
    
    func croppedImage(_ image: UIImage, cropRect: CGRect, scale imageScale: CGFloat, orientation imageOrientation: UIImageOrientation) -> UIImage {
        let croppedCGImage: CGImage? = image.cgImage?.cropping(to: cropRect)
        let croppedImage = UIImage(cgImage: croppedCGImage!, scale: imageScale, orientation: imageOrientation)
        return croppedImage
        
    }
    
    func croppedImage(_ image: UIImage, cropRect: CGRect, rotationAngle: CGFloat, zoomScale: CGFloat, maskPath: UIBezierPath, applyMaskToCroppedImage: Bool) -> UIImage {
        
        let imageSize: CGSize = image.size
        let x: CGFloat = cropRect.minX
        let y: CGFloat = cropRect.minY
        let width: CGFloat = cropRect.width
        let height: CGFloat = cropRect.height
        var imageOrientation: UIImageOrientation = image.imageOrientation
        var croppedRect2 = cropRect
        
        if imageOrientation == .right || imageOrientation == .rightMirrored {
            croppedRect2.origin.x = y
            croppedRect2.origin.y = round(imageSize.width - cropRect.width - x)
            croppedRect2.size.width = height
            croppedRect2.size.height = width
        }
        else if imageOrientation == .left || imageOrientation == .leftMirrored {
            croppedRect2.origin.x = round(imageSize.height - cropRect.height - y)
            croppedRect2.origin.y = x
            croppedRect2.size.width = height
            croppedRect2.size.height = width
        }
        else if imageOrientation == .down || imageOrientation == .downMirrored {
            croppedRect2.origin.x = round(imageSize.width - cropRect.width - x)
            croppedRect2.origin.y = round(imageSize.height - cropRect.height - y)
        }
        
        let imageScale: CGFloat = image.scale
        croppedRect2 = cropRect.applying(CGAffineTransform(scaleX: imageScale, y: imageScale))
        
        // Step 2: create an image using the data contained within the specified rect.
        var croppImage: UIImage? = croppedImage(image, cropRect: cropRect, scale: imageScale, orientation: imageOrientation)
        
        // Step 3: fix orientation of the cropped image.
        //croppImage = croppImage?.fixOrientation()
        imageOrientation = (croppImage?.imageOrientation)!
        
        // Step 5: create a new context.
        let maskSize: CGSize = maskPath.bounds.integral.size
        let contextSize = CGSize(width: CGFloat(ceil(maskSize.width / zoomScale)), height: CGFloat(ceil(maskSize.height / zoomScale)))
        UIGraphicsBeginImageContextWithOptions(contextSize, false, imageScale)
        
        // 6a: scale the mask to the size of the crop rect.
        let maskPathCopy: UIBezierPath? = maskPath
        let scale: CGFloat = 1 / zoomScale
        maskPathCopy?.apply(CGAffineTransform(scaleX: scale, y: scale))
        
        // 6b: move the mask to the top-left.
        let translation = CGPoint(x: CGFloat(-((maskPathCopy?.bounds.minX)!)), y: CGFloat(-((maskPathCopy?.bounds.minY)!)))
        maskPathCopy?.apply(CGAffineTransform(translationX: translation.x, y: translation.y))
        
        
        // 6c: apply the mask.
        maskPathCopy?.addClip()
        
        
        // Step 8: draw the cropped image.
        let point = CGPoint(x: CGFloat(round((contextSize.width - (croppImage?.size.width)!) * 0.5)), y: CGFloat(round((contextSize.height - (croppImage?.size.height)!))))
        //let point = CGPoint(x: 0, y: 0)
        croppImage?.draw(at: point)
        
        // Step 9: get the cropped image affter processing from the context.
        croppImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // Step 10: remove the context.
        UIGraphicsEndImageContext()
        croppImage = UIImage(cgImage: (croppImage?.cgImage)!)
        
        // Step 11: return the cropped image affter processing.
        
        
        return croppImage!
        
        
        
    }
    
    func croppedImage2(_ image: UIImage, cropRect: CGRect, rotationAngle: CGFloat, zoomScale: CGFloat, maskPath: UIBezierPath, applyMaskToCroppedImage: Bool) -> UIImage {
    
        // Step 1: check and correct the crop rect.
        let imageSize: CGSize = image.size
        let x: CGFloat = cropRect.minX
        let y: CGFloat = cropRect.minY
        let width: CGFloat = cropRect.width
        let height: CGFloat = cropRect.height
        var imageOrientation: UIImageOrientation = image.imageOrientation
        var croppedRect2 = cropRect
        
        if imageOrientation == .right || imageOrientation == .rightMirrored {
            
            //print("paso 1")
            croppedRect2.origin.x = y
            croppedRect2.origin.y = round(imageSize.width - cropRect.width - x)
            croppedRect2.size.width = height
            croppedRect2.size.height = width
        
        }
        
        
        let croppImage: UIImage? = croppedImage(image, cropRect: croppedRect2, scale: 1.0, orientation: imageOrientation)
        
        return croppImage!
    }
    
    
    
}
