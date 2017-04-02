import UIKit

public class TitleLabel: UILabel {
    
    public init(sortingAlg: Algorithm) {
        super.init(frame: .zero)
        
        text = "\(sortingAlg.name) - \(sortingAlg.runTime)"
        font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightBlack)
        textAlignment = .center
        textColor = Theme.gold
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
