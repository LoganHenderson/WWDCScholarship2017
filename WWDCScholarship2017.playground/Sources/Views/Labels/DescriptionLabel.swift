import UIKit

public class DescriptionLabel: UILabel {
    

    public init(text: String) {
        super.init(frame: .zero)
        
        self.text = text
        textAlignment = .center
        numberOfLines = 0
        baselineAdjustment = .alignCenters
        font = UIFont.systemFont(ofSize: 9.0)
  
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
