import Foundation

public enum ListAnimationType {
    case accessAnimationType, swapAnimationType, insertAnimationType, mergeAnimationType
}

public struct ListAnimation {
    public let name: ListAnimationType
    public let indxs: ([Int], [Int])
}
