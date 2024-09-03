//
//  ExploreCollectionViewCell.swift
//  ASISProject3
//
//  Created by Armağan Gül on 25.08.2024.
//

import UIKit

class ExploreCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "ExploreCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    public func configure(with image: UIImage){
        self.myImageView.image = image
        self.setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
    }
}

    

