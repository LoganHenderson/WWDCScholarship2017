import UIKit

public class FacialDetection {
    
    public static func getFaces(from image: UIImage) -> [Face] {
        
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: CIContext(), options: [CIDetectorAccuracy : CIDetectorAccuracyHigh, CIDetectorReturnSubFeatures : true])
        
        let ciImage = CIImage(image: image)
        let features = detector?.features(in: ciImage!)
        
        var faces: [Face] = []
        
        if let features = features {
            var faceCount = 0

            for feature in features {
                
                if feature.isKind(of: CIFaceFeature.classForCoder()) {
                    let convertedBounds = adjustedBounds(bounds: feature.bounds, image: image)
                    let faceImage = image.croppedImageWithRect(rect: convertedBounds)
                    let face = Face(image: faceImage, frame: convertedBounds, index: faceCount)
                    faces.append(face)
                    faceCount += 1
                }
            }
        }
        return faces
    }
    
    private static func adjustedBounds(bounds: CGRect, image: UIImage) -> CGRect {
        return CGRect(x: bounds.origin.x, y: image.size.height - bounds.size.height - bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }

    
}
