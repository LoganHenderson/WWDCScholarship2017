import Foundation

public class Constants {
    
    public struct ErrorLogs {
        
        public static let kMusicFileDoesntExist = NSLocalizedString("could not unwrap music file", comment: "")

    }
    
    public struct sortViewText {
        
        public static let kUnsortedState    = NSLocalizedString("Unsorted", comment: "")
        public static let kSortingState     = NSLocalizedString("Sorting", comment: "")
        public static let kSortedState      = NSLocalizedString("Sorted", comment: "")
        
        public static let numberDescription = NSLocalizedString("The numbers below each face represent relative height and are calculated by 200 - x, where x is the number of points between the face and the top of the original image shown above", comment: "")
    }
    
    public struct iconImages {
        
        public static let PlayButtonImageName       = "playIcon"
        public static let PauseButtonImageName      = "pauseIcon"
        public static let ShuffleButtonImageName    = "refreshIcon"
        
    }

}
