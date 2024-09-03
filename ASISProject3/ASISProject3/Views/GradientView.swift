//
//  GradientView.swift
//  ASISProject3
//
//  Created by Armağan Gül on 30.08.2024.
//

import Foundation
import QuartzCore
import UIKit

class GradientView: UIView {

    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 1.0)]
        gradientLayer.locations = [0.0, 1.0] // Gradient transition positions
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0) // Gradient starts from top
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1) // Gradient ends at the bottom
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
}
