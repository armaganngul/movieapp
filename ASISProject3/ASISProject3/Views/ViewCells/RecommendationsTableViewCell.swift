//
//  RecommendationCollectionViewCell.swift
//  ASISProject3
//
//  Created by Armağan Gül on 25.08.2024.
//

import UIKit
import SDWebImage

class RecommendationsTableViewCell: UITableViewCell {
    static var identifier = "RecommendationsTableViewCell"
    
    let customCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    let image: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "CoolveticaRg-Regular", size: 24)
         
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "CoolveticaRg-Regular", size: 14)
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        return label
   }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customCell)
        contentView.backgroundColor = UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 1.0)
        customCell.addSubview(image)
        customCell.addSubview(title)
        customCell.addSubview(overviewLabel)
        
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with movie: MovieEntity) {
        guard let posterPath = movie.posterPath else {
            image.image = UIImage(named: "placeholder")
            return
        }

        let fullPosterURL = "https://image.tmdb.org/t/p/w200\(posterPath)"
        if let url = URL(string: fullPosterURL) {
            image.sd_setImage(with: url, completed: nil)
        } else {
            image.image = UIImage(named: "placeholder")
        }
        title.text = movie.title
        overviewLabel.text = movie.overview
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            customCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            customCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            customCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            image.leadingAnchor.constraint(equalTo: customCell.leadingAnchor, constant: 10),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 147),
            image.centerYAnchor.constraint(equalTo: customCell.centerYAnchor),
            
            title.topAnchor.constraint(equalTo: image.topAnchor, constant: -7),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: customCell.trailingAnchor, constant: -5),
            
            overviewLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: customCell.trailingAnchor, constant: -25),
            overviewLabel.bottomAnchor.constraint(equalTo: customCell.bottomAnchor, constant: -10) // Add bottom constraint
        ])
    }
}


