//
//  SortOptionButton.swift
//  PlaygroundTest
//
//  Created by Logan Henderson on 4/1/17.
//  Copyright © 2017 LoganHenderson. All rights reserved.
//

import UIKit

public class SortOptionButton: UIButton {
    
    public var algorithm: Algorithm
    
    public init(with algorithm: Algorithm) {
        self.algorithm = algorithm
        super.init(frame: .zero)
        setTitle(algorithm.name, for: .normal)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
