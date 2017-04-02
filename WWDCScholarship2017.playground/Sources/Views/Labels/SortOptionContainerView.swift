//
//  SortOptionContainerView.swift
//  PlaygroundTest
//
//  Created by Logan Henderson on 3/31/17.
//  Copyright © 2017 LoganHenderson. All rights reserved.
//

import UIKit

public class SortOptionContainerView: UIView {
    
    public var buttons: [UIButton] = []
    
    public init(algorithmChoices: [Algorithm]) {
        super.init(frame: .zero)
        algorithmChoices.forEach {
            let button = SortOptionButton(with: $0)
            buttons.append(button)
        }
        let stackView = LayoutHelper.fillEquallyInStackView(buttons,
                                                            axis: .horizontal,
                                                            distribution: .fillEqually,
                                                            alignment: .fill,
                                                            spacing: 0)
        addSubview(stackView)
        LayoutHelper.pinToSubview(stackView, to: self)
    }
    
    public func resetButtons() {
        buttons.forEach { (button) in
            button.backgroundColor = Theme.blue
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
