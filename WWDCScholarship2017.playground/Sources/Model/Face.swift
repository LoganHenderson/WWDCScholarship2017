import UIKit


public class Face: CustomStringConvertible {
    
    public let height: Int
    public let faceImage: UIImage
    public let frameInImage: CGRect
    public var indexInList: Int
    
    public init(image: UIImage, frame: CGRect, index: Int) {
        faceImage = image
        frameInImage = frame
        height = Int(frame.origin.y)
        indexInList = index
    }
    
    public var description: String {
        return "\(height)"
    }
}

extension Face: Equatable, Comparable {

    public static func ==(lhs: Face, rhs: Face) -> Bool {
        return lhs.height == rhs.height
    }
    
    public static func <(lhs: Face, rhs: Face) -> Bool {
        return lhs.height < rhs.height
    }
    
}
