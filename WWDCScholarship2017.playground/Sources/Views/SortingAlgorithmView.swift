import UIKit

let buttonWidth = CGFloat(50)
var animationDurationLength = 0.4

public class SortingAlgorithmView: UIView {
    
    var scrollView: UIScrollView
    var sortedLabel: SortLabel
    var playButton: PlayButton
    var animationTimer:Timer?
    
    public var faceButtons: [FaceButton] = []
    public var algAnimations: [ListAnimation] = []
    public var algorithm: Algorithm
    
    let musicHelper = MusicHelper()
    
    var lastLocation = CGPoint(x: 0, y: 0)

    func sortFacesFromButtonList() {
        algAnimations = []
        var faceList: [Face] = []
        for button in faceButtons { faceList.append(button.face) }
        sortFaces(faces: faceList)
        sortedLabel.sortState = .sorting
        playButton.sortState = .playing
    }
    

    public init(sortingAlg: Algorithm, faceList: [Face]) {
        
        scrollView = UIScrollView()
        algorithm = sortingAlg
        sortedLabel = SortLabel()
        playButton = PlayButton()
        
        super.init(frame: .zero)
        
        clipsToBounds = true
        layer.cornerRadius = 35
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        isUserInteractionEnabled = true
        scrollView.clipsToBounds = false
        scrollView.isUserInteractionEnabled = true
        
        createFaceButtons(with: faceList)
        
        let slider = UISlider()
        slider.setValue(Float(animationDurationLength), animated: false)
        slider.addTarget(self, action: #selector(sliderDidChange(slider:)), for: .valueChanged)
        slider.heightAnchor.constraint(equalToConstant: 20).isActive = true
        slider.widthAnchor.constraint(equalToConstant: 250).isActive = true // dont think is working
        slider.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)

        let desclabel = DescriptionLabel(text: Constants.sortViewText.numberDescription)
        desclabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        desclabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
        sortedLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortedLabel.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        
        playButton.addTarget(self, action: #selector(playButtonPressedUpInside), for: .touchUpInside)
        playButton.sortState = .paused
        scrollView.frame = CGRect(x: 0, y: 0, width: (faceList.count * Int(buttonWidth)), height: 200)

        let middleStack = LayoutHelper.fillEquallyInStackView([playButton, scrollView], axis: .horizontal, distribution: .fill, alignment: .fill, spacing: 5)
    
        let algStack = LayoutHelper.fillEquallyInStackView([TitleLabel(sortingAlg: sortingAlg), slider, middleStack, desclabel, sortedLabel], axis: .vertical, distribution: .fillProportionally, alignment: .fill, spacing: 15)
        addSubview(algStack)
        LayoutHelper.pinToSubview(algStack, to: self)
        
        sortedLabel.sortState = .unsorted
    }
    
    func createFaceButtons(with faceList: [Face]) {
        for i in 0..<faceList.count {
            
            let faceButton = FaceButton(face: faceList[i])
            faceButton.frame = CGRect(x: (CGFloat(i) * buttonWidth),
                                      y: 0,
                                      width: buttonWidth,
                                      height: CGFloat(160 - faceList[i].height))
            let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan(gestureRecognizer:)))
            faceButton.gestureRecognizers = [panRecognizer]
            scrollView.addSubview(faceButton)
            faceButtons.append(faceButton)
        }
    }
    
    func sliderDidChange(slider: UISlider) {

        animationTimer?.invalidate()
        animationTimer = nil
        playButton.sortState = .paused
        animationDurationLength = (Double(max(min(1.0, slider.value), Float(0.1))))
    }
    
    private func shuffleFaces() {
        faceButtons.shuffle()
        UIView.animate(withDuration: animationDurationLength, animations: {
            for x in 0..<self.faceButtons.count {
                let currentFrame = self.faceButtons[x].frame
                
                self.faceButtons[x].frame = CGRect(x: CGFloat(x) * buttonWidth, y: currentFrame.origin.y, width: currentFrame.width, height: currentFrame.height)
            }
            self.sortedLabel.sortState = .unsorted
            self.playButton.sortState = .paused
        })
    }

    public func playButtonPressedUpInside() {
        
        musicHelper.playSound(.button)
        
        if playButton.sortState == .finished {
            shuffleFaces()

        } else if playButton.sortState == .paused {
            
            sortFacesFromButtonList()

            
        } else if playButton.sortState == .playing {
            
            animationTimer?.invalidate()
            animationTimer = nil
            playButton.sortState = .paused
            
        }
    }
    
    public func endAnimations() {
        animationTimer?.invalidate()
        animationTimer = nil
    }
    
    
    public func detectPan(gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            endAnimations()
            
            if gestureRecognizer.state == .began {
                lastLocation = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y)
            }
            
            let translation = gestureRecognizer.translation(in: self)
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self)
            
        } else if gestureRecognizer.state == .ended {
            
            print("veloctiy : \(Int(gestureRecognizer.velocity(in: self).x)) \(Int(gestureRecognizer.velocity(in: self).y))")
            
            let translation = gestureRecognizer.translation(in: self)
            let newXLocation = gestureRecognizer.view!.center.x + translation.x
            
            let oldIndex = Int(lastLocation.x) / Int(buttonWidth)
            var newIndex = Int(newXLocation) / Int(buttonWidth)
            
            if (oldIndex != newIndex) {
                playButton.sortState = .paused
                sortedLabel.sortState = isSorted() ? .sorted : .unsorted
            }
            
            newIndex = (newIndex < 0) ? 0 :  newIndex
            newIndex = (newIndex < self.faceButtons.count) ? newIndex : self.faceButtons.count - 1
            
            Timer.scheduledTimer(timeInterval: 0.2,
                                 target: self,
                                 selector: #selector(moveButton(timer:)),
                                 userInfo: ["ind1" : newIndex,
                                            "ind2" : oldIndex],
                                 repeats: false)
        }
    }
    
    func moveButton(timer: Timer) {
        
        if let dict = timer.userInfo as? [String : Int] {
            
            insertAnimation(indexes: (dict["ind1"]!, dict["ind2"]!))
        }
    }
    
    
    public func sortFaces(faces: [Face]) {
        
        algAnimations = []
        
        if (algorithm.name == bubbleSortAlg.name) {
            
            algAnimations = bubbleSort(faces: faces)
            
        } else if (algorithm.name == insertionSortAlg.name) {
            
            algAnimations = insertionSort(faces: faces)
            
        } else if (algorithm.name == mergeSortAlg.name) {
            resetFaceIndexes()
            let _ = mergeSort(faces)
            
        }
        
        animationTimer = Timer.scheduledTimer(timeInterval: animationDurationLength,
                                        target: self,
                                        selector: #selector(fireAnimation),
                                        userInfo: nil,
                                        repeats: true)
    }
    
    func fireAnimation() {
        
        // When animations are finished adjust UI and stop the timer
        guard let animation = algAnimations.first else {
            if algAnimations.count == 0 {
                animationTimer?.invalidate()
                animationTimer = nil
                sortedLabel.sortState = .sorted
                playButton.sortState = .finished
            }
            return
        }
        
        switch animation.name {
        case .accessAnimationType:
            accessAnimation(indexes: animation.indxs.0 + animation.indxs.1)
        case .swapAnimationType:
            swapAnimation(indexes: (animation.indxs.0.first!, animation.indxs.1.first!))
        case .insertAnimationType:
            DispatchQueue.global(qos: .userInteractive).async {
                self.musicHelper.playSound(.insert)
            }
            insertAnimation(indexes: (animation.indxs.0.first!, animation.indxs.1.first!))
        case .mergeAnimationType:
            mergeAnimation(indexes: (animation.indxs.0, animation.indxs.1))
        }
        
//        // Fire the necessary animation
//        if animation.name == .accessAnimationType {
//            accessAnimation(indexes: animation.indxs.0 + animation.indxs.1)
//        } else if animation.name == .swapAnimationType {
//            swapAnimation(indexes: (animation.indxs.0.first!, animation.indxs.1.first!))
//        } else if animation.name == .insertAnimationType {
//            DispatchQueue.global(qos: .userInteractive).async {
//                self.musicHelper.playSound(.insert)
//            }
//            insertAnimation(indexes: (animation.indxs.0.first!, animation.indxs.1.first!))
//        } else if animation.name == .mergeAnimationType {
//            mergeAnimation(indexes: (animation.indxs.0, animation.indxs.1))
//        }
        
        algAnimations.remove(at: 0)
    }
    
    // MARK: Animations
    
    func mergeAnimation(indexes: ([Int], [Int])) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.musicHelper.playSound(.merge)
        }
            var leftPile = indexes.0.sorted()
            let rightPile = indexes.1.sorted()
        
            for x in 0..<rightPile.count {

                
                for y in stride(from: 0, through: leftPile.count - 1, by: 1) {
                    
                    
                    if (faceButtons[rightPile[x]].face > faceButtons[leftPile[y]].face) {
                        insertAnimation(indexes: (leftPile[y], rightPile[x]))
                        leftPile.append(rightPile[x])
                    }
                }
            }
    }
    
    func swapAnimation(indexes: (Int, Int)) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.musicHelper.playSound(.swap)
        }
            let temp = faceButtons[indexes.0]
            faceButtons[indexes.0] = faceButtons[indexes.1]
            faceButtons[indexes.1] = temp
        
            UIView.animate(withDuration: animationDurationLength) {
                let origin = self.faceButtons[indexes.0].frame.origin
                self.faceButtons[indexes.0].frame.origin = self.faceButtons[indexes.1].frame.origin
                self.faceButtons[indexes.1].frame.origin = origin
            }
    }
    
    func resetColor(timer: Timer) {
        if let dict = timer.userInfo as? [String : [Int]] {
            for indx in dict["indexes"]! {
                faceButtons[indx].backgroundColor = UIColor.lightGray
            }
        }
    }
    
    func accessAnimation(indexes: [Int]) {

        DispatchQueue.global(qos: .userInteractive).async {
            self.musicHelper.playSound(.access)
        }
        
        for indx in indexes {
            faceButtons[indx].backgroundColor = UIColor.green
        }
        
        Timer.scheduledTimer(timeInterval: animationDurationLength - 0.02,
                             target: self,
                             selector: #selector(resetColor),
                             userInfo: ["indexes" : indexes],
                             repeats: false)
    }
    
    func insertAnimation(indexes: (Int, Int)) {
            UIView.animate(withDuration: animationDurationLength) {
                
                let positionToInsertIn = indexes.0
                let objectToInsert = indexes.1

                if objectToInsert > positionToInsertIn {
                    
                    let tempButton = self.faceButtons[objectToInsert]
                    self.faceButtons[objectToInsert].frame.origin = self.faceButtons[positionToInsertIn].frame.origin
                
                    for x in stride(from: objectToInsert, to: positionToInsertIn, by: -1) {
                        let currentFrame = self.faceButtons[x - 1].frame.origin
                        self.faceButtons[x - 1].frame.origin = CGPoint(x: currentFrame.x + buttonWidth, y: currentFrame.y)
                        self.faceButtons[x] = self.faceButtons[x - 1];
                    }
                    
                    self.faceButtons[positionToInsertIn] = tempButton
                    
                } else if objectToInsert < positionToInsertIn {
                    
                    let tempButton = self.faceButtons[objectToInsert]
                    self.faceButtons[objectToInsert].frame.origin = self.faceButtons[positionToInsertIn].frame.origin
                    
                    for x in stride(from: objectToInsert, to: positionToInsertIn, by: 1) {
                        let currentFrame = self.faceButtons[x + 1].frame.origin
                        self.faceButtons[x + 1].frame.origin = CGPoint(x: currentFrame.x - buttonWidth, y: currentFrame.y)
                        self.faceButtons[x] = self.faceButtons[x + 1];
                    }
                    
                    self.faceButtons[positionToInsertIn] = tempButton
                } else {
                    

                    let oldFrameX = (buttonWidth * CGFloat(objectToInsert))
                    
                    self.faceButtons[objectToInsert].frame = CGRect(x: oldFrameX, y: 0, width: buttonWidth, height: self.faceButtons[objectToInsert].frame.size.height)
                }
                
            }
    }

    // MARK: Helper Methods
    public func isSorted() -> Bool {
        for x in 1..<faceButtons.count {
            if faceButtons[x].face < faceButtons[x - 1].face { return false }
        }
        return true
    }
    
    // Used to reset index for faces (this is necessary to keep track of which indexes to animate in recursive sorting functions)
    func resetFaceIndexes() {
        for x in 0..<faceButtons.count { faceButtons[x].face.indexInList = x }
    }

    // Required init
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Array
{
    
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<count
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
