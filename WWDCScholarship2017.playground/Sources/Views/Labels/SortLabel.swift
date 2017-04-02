//
//  SortLabel.swift
//  PlaygroundTest
//
//  Created by Logan Henderson on 3/23/17.
//  Copyright © 2017 LoganHenderson. All rights reserved.
//

import UIKit

public enum SortedStateType {
    case unsorted, sorting, sorted
}

public class SortLabel: UILabel {
    
    public var sortState: SortedStateType {
        didSet {
            switch sortState {
            case .unsorted:
                text = Constants.sortViewText.kUnsortedState
                backgroundColor = UIColor.black
            case .sorting:
                text = Constants.sortViewText.kSortingState
                backgroundColor = UIColor.blue
            case .sorted:
                text = Constants.sortViewText.kSortedState
                backgroundColor = UIColor.green
            }
        }
    }
    
    public init() {
        sortState = .unsorted
        super.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        textAlignment = .center
        textColor = UIColor.white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
