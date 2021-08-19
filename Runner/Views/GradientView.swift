//
//  GradientView.swift
//  Runner
//
//  Created by Anton Tuzov on 19.08.2021.
//

import UIKit

final class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    init(colors: [UIColor]) {
        super.init(frame: .zero)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
