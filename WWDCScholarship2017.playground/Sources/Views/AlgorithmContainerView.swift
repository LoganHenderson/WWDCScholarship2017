import UIKit

public class AlgorithmContainerView: UIView {
    
    
    private var imgView: UIImageView
    private var sortView: SortingAlgorithmView
    private var sortOptions: SortOptionContainerView!
    private var stackView: UIStackView!
    
    private let images = [bubbleSortAlg.name: UIImage(named: "Group1")!,
                          insertionSortAlg.name: UIImage(named: "Group2")!,
                          mergeSortAlg.name: UIImage(named: "Group3")!]
    
    private let algorthims = [bubbleSortAlg,
                              insertionSortAlg,
                              mergeSortAlg]
    
    public override init(frame: CGRect) {

        let algorithm = algorthims.first!
        let anImage = images[algorithm.name]!
        
        sortView = SortingAlgorithmView(sortingAlg: algorithm, faceList:  FacialDetection.getFaces(from: anImage))
        sortOptions = SortOptionContainerView(algorithmChoices: algorthims)
        imgView = UIImageView(image: anImage)
        
        super.init(frame: frame)
        
        imgView.contentMode = .scaleAspectFit
        backgroundColor = Theme.blue
        sortOptions.buttons.first?.backgroundColor = Theme.gold
        for button in sortOptions.buttons {
            button.addTarget(self, action: #selector(buttonPressed(withButton:)), for: .touchUpInside)
        }
        
        imgView.heightAnchor.constraint(equalToConstant: frame.size.height * 0.25).isActive = true
        imgView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        sortView.heightAnchor.constraint(equalToConstant: (frame.size.height * 0.6)).isActive = true
        sortView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        
        stackView = LayoutHelper.fillEquallyInStackView([sortOptions, imgView, sortView] , axis: .vertical, distribution: .fill, alignment: .fill, spacing: 15)
        addSubview(stackView)
        LayoutHelper.pinToSubview(stackView, to: self, constants: (15, -15, -15, 15))
    }
    
    func buttonPressed(withButton button:UIButton) {

        if button.titleLabel?.text == sortView.algorithm.name { return }
        
        sortView.endAnimations()
        sortOptions.resetButtons()
        button.backgroundColor = Theme.gold

        DispatchQueue.main.async {

            self.stackView.removeArrangedSubview(self.sortView)
            self.sortView.removeFromSuperview()

            if button.titleLabel?.text == bubbleSortAlg.name {

                self.imgView.image = UIImage(named: "Group1")!
                self.sortView = SortingAlgorithmView(sortingAlg: bubbleSortAlg, faceList:  FacialDetection.getFaces(from: self.imgView.image!))
                

            } else if button.titleLabel?.text == insertionSortAlg.name {

                self.imgView.image = UIImage(named: "Group2")!
                self.sortView = SortingAlgorithmView(sortingAlg: insertionSortAlg, faceList:  FacialDetection.getFaces(from: self.imgView.image!))

            }  else if button.titleLabel?.text == mergeSortAlg.name {

                self.imgView.image = UIImage(named: "Group3")!
                self.sortView = SortingAlgorithmView(sortingAlg: mergeSortAlg, faceList:  FacialDetection.getFaces(from: self.imgView.image!))

            }

            self.sortView.heightAnchor.constraint(equalToConstant: (self.frame.size.height * 0.6)).isActive = true
            self.sortView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
            
            self.stackView.addArrangedSubview(self.sortView)
            
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

