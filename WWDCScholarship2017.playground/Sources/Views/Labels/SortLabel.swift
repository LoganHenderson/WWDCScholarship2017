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

    public init() {
        super.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        textAlignment = .center
        textColor = UIColor.white
    }
    
    func setLabelForState(state: SortedStateType) {
        
        switch state {
        case .unsorted:
            text = Constants.sortState.kUnsortedState
            backgroundColor = UIColor.black
        case .sorting:
            text = Constants.sortState.kSortingState
            backgroundColor = UIColor.blue
        case .sorted:
            text = Constants.sortState.kSortedState
            backgroundColor = UIColor.green
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
