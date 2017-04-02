//
//  LayoutHelper.swift
//  PlaygroundTest
//
//  Created by Logan Henderson on 3/20/17.
//  Copyright © 2017 LoganHenderson. All rights reserved.
//

import UIKit

public class LayoutHelper {
    
    public static let zeroConstants: (Int, Int, Int, Int) = (0, 0, 0, 0)
    
    public static func pinToSubview(_ subview: UIView, to superView: UIView) {
        pinToSubview(subview, to: superView, constants: zeroConstants)
    }
    
    public static func pinToSubview(_ subview: UIView, to superView: UIView, constants: (Int, Int, Int, Int)) {
        subview.topAnchor.constraint(equalTo: superView.topAnchor, constant: CGFloat(constants.0)).isActive = true
        subview.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: CGFloat(constants.1)).isActive = true
        subview.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: CGFloat(constants.2)).isActive = true
        subview.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: CGFloat(constants.3)).isActive = true
    }
    
    public static func fillEquallyInStackView(_ views: [UIView], axis: UILayoutConstraintAxis, distribution: UIStackViewDistribution, alignment: UIStackViewAlignment, spacing: CGFloat) -> UIStackView {
        
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = true
        
        return stackView
    }

    
}
