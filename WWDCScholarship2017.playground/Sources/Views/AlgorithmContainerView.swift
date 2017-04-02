import UIKit

public class AlgorithmContainerView: UIView {
    
    
    private var imgView: UIImageView
    private var sortView: SortingAlgorithmView
    private var sortOptions: SortOptionContainerView!
    private var stackView: UIStackView!
    
    public init() {
        
        
        let anImage = UIImage(named: "Group1")!
        sortView = SortingAlgorithmView(sortingAlg: bubbleSortAlg, faceList:  FacialDetection.getFaces(from: anImage))
        imgView = UIImageView(image: anImage)
        imgView.contentMode = .scaleAspectFit
        
        super.init(frame: CGRect(x: 0, y: 0, width: 500, height: 700))
        
        backgroundColor = Theme.blue
        
        sortOptions = SortOptionContainerView(algorithmChoices: [bubbleSortAlg, insertionSortAlg, mergeSortAlg])
        sortOptions.buttons.first?.backgroundColor = Theme.gold
        for button in sortOptions.buttons {
            button.addTarget(self, action: #selector(buttonPressed(withButton:)), for: .touchUpInside)
        }
        
        sortOptions.heightAnchor.constraint(equalToConstant: 120).isActive = true
        sortOptions.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        
        sortView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        sortView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        
        stackView = LayoutHelper.fillEquallyInStackView([sortOptions, imgView, sortView] , axis: .vertical, distribution: .fill, alignment: .fill, spacing: 0)
        addSubview(stackView)
        LayoutHelper.pinToSubview(stackView, to: self, constants: (0, -15, -15, 15))
    }
    
    func buttonPressed(withButton button:UIButton) {

        if button.titleLabel?.text == sortView.algorithm.name { return }

        sortOptions.resetButtons()
        button.backgroundColor = Theme.gold

        DispatchQueue.main.async {

            self.stackView.removeArrangedSubview(self.sortView)
            self.sortView.removeFromSuperview()

            if button.titleLabel?.text == bubbleSortAlg.name {

                self.imgView.image = UIImage(named: "Group1")!
                self.sortView = SortingAlgorithmView(sortingAlg: bubbleSortAlg, faceList:  FacialDetection.getFaces(from: self.imgView.image!))
                

            } else if button.titleLabel?.text == insertionSortAlg.name {

                self.imgView.image = UIImage(named: "Group3")!
                self.sortView = SortingAlgorithmView(sortingAlg: insertionSortAlg, faceList:  FacialDetection.getFaces(from: self.imgView.image!))

            }  else if button.titleLabel?.text == mergeSortAlg.name {

                self.imgView.image = UIImage(named: "Group4")!
                self.sortView = SortingAlgorithmView(sortingAlg: mergeSortAlg, faceList:  FacialDetection.getFaces(from: self.imgView.image!))

            }

            self.sortView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            self.sortView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
            
            self.stackView.addArrangedSubview(self.sortView)
            
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

