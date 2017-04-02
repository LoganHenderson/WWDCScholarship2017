//
//  PlayButton.swift
//  PlaygroundTest
//
//  Created by Logan Henderson on 3/29/17.
//  Copyright © 2017 LoganHenderson. All rights reserved.
//

import UIKit

public enum PlayButtonState {
    case playing, paused, finished
}

public class PlayButton: UIButton {
    
    public var sortState: PlayButtonState {
        didSet {
            
            switch sortState {
            case .playing:
                setImage(UIImage(named: Constants.iconImages.PauseButtonImageName)!, for: .normal)
            case .paused:
                setImage(UIImage(named: Constants.iconImages.PlayButtonImageName)!, for: .normal)
            case .finished:
                setImage(UIImage(named: Constants.iconImages.ShuffleButtonImageName)!, for: .normal)
            }
        }
    }
    public init() {
        sortState = .paused
        super.init(frame: .zero)
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
