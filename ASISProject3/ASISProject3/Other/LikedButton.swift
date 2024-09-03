//
//  LikedButton.swift
//  ASISProject3
//
//  Created by Armağan Gül on 30.08.2024.
//
import Foundation
import UIKit

class LikeButton: UIButton {
    
    init(isLiked: Bool) {
        super.init(frame: .zero)
        
        // Button configuration
        let config = UIImage.SymbolConfiguration(pointSize: 70, weight: .medium, scale: .default)
        let unfilledHeart = UIImage(systemName: "heart", withConfiguration: config)
        let filledHeart = UIImage(systemName: "heart.fill", withConfiguration: config)
        
        if isLiked {
            self.setImage(filledHeart, for: .normal)
            self.isSelected = true
        } else {
            self.setImage(unfilledHeart, for: .normal)
            self.isSelected = false
        }
        
        self.contentMode = .center
        self.imageView?.contentMode = .scaleAspectFit
        self.tintColor = .systemTeal
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
        
        // Adding target for toggle action
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        self.isSelected.toggle()
        let config = UIImage.SymbolConfiguration(pointSize: 70, weight: .medium, scale: .default)
        let filledHeart = UIImage(systemName: "heart.fill", withConfiguration: config)
        let unfilledHeart = UIImage(systemName: "heart", withConfiguration: config)
        
        if self.isSelected {
            self.setImage(filledHeart, for: .normal)
        } else {
            self.setImage(unfilledHeart, for: .normal)
        }
    }
}
