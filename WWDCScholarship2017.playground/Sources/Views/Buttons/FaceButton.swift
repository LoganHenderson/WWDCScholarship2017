import UIKit

public class FaceButton: UIButton {
    
    public let face: Face
    public let faceImageView: UIImageView
    public let heightLabel: UILabel
    
    override public var description: String {
        return "\(face.height)"
    }
    
    public init(face: Face) {

        self.face = face
        faceImageView = UIImageView(image: face.faceImage)
        heightLabel = UILabel()
        
        super.init(frame: .zero)

        backgroundColor = UIColor.lightGray
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        
        faceImageView.contentMode = .scaleAspectFit
        faceImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        faceImageView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        
        heightLabel.text = "\(200 - face.height)"
        heightLabel.textAlignment = .center
        heightLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightBold)
        
        let stackView = LayoutHelper.fillEquallyInStackView([faceImageView, heightLabel], axis: .vertical, distribution: .fillProportionally, alignment: .fill, spacing: 5)
        addSubview(stackView)
        LayoutHelper.pinToSubview(stackView, to: self)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
