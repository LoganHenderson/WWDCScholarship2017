import UIKit

extension UIImage {
    
    public func croppedImageWithRect(rect: CGRect) -> UIImage {
        let imageRef = cgImage!.cropping(to: rect)
        let result = UIImage(cgImage: imageRef!)
        return result
    }
    
}
