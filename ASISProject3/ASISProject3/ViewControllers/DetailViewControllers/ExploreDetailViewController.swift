//
//  MovieDetailViewController.swift
//  ASISProject3
//
//  Created by Armağan Gül on 30.08.2024.
//

import UIKit

class ExploreDetailViewController: UIViewController {
    private var movie: MovieEntity
    private var cast: [String] = []
    private var movieAPI = MovieAPI()
    private var movieGenre: [String] = []
    let dataController = DataController.shared

    let outsideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 1.0)
        return view
    }()
    
    let insideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 0.5)
        return view
    }()

    let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        imageview.image = UIImage(systemName: "questionmark")
        imageview.clipsToBounds = true
        imageview.alpha = 0.9
        return imageview
    }()
    
     let movietitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "CoolveticaRg-Regular", size: 30)
        return label
    }()
    
    let castMembers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "CoolveticaRg-Regular", size: 15)
        return label
   }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "CoolveticaRg-Regular", size: 15)
        return label
   }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "CoolveticaRg-Regular", size: 13)
        return label
   }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "CoolveticaRg-Regular", size: 14)
        return label
   }()
    
    private let likeButton: UIButton = {
        
        let config = UIImage.SymbolConfiguration(pointSize: 70, weight: .medium, scale: .default)
        
        var button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .selected)
        button.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: [.selected, .highlighted])
        
        button.contentMode = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemTeal
        button.backgroundColor = .clear
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
        }()
    
    @objc private func buttonTapped() {
        toggleImage()
                
        if movieInDB(movietocheck: movie){
            dataController.deleteMovieEntity(movieid: Int64(movie.id!))
        } else {
            let success = dataController.saveMovieEntity(movieid: Int64(movie.id!))
            if success {
                print("Movie saved successfully!")
            } else {
                print("Failed to save the movie.")
            }
        }
        updateLikeButtonState()
    }
    
    func movieInDB(movietocheck: MovieEntity) -> Bool{
        let likedMovies = dataController.fetchLikedMovies()
        let isLiked = likedMovies.contains { $0.likedmovieid == Int64(movietocheck.id!) }
        print("Is movie liked: \(isLiked)")
        return isLiked
    }
    
    private func toggleImage() {
        likeButton.isSelected = !likeButton.isSelected
    }
    
    func setUp(){
            view.addSubview(outsideView)
            outsideView.addSubview(imageView)
            view.addSubview(insideView)
            insideView.addSubview(movietitle)
            insideView.addSubview(castMembers)
            insideView.addSubview(genreLabel)
            insideView.addSubview(overviewLabel)
            insideView.addSubview(dateLabel)
            insideView.addSubview(likeButton)
                
        NSLayoutConstraint.activate([
                outsideView.topAnchor.constraint(equalTo: imageView.topAnchor),
                outsideView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                outsideView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                outsideView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                outsideView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                insideView.topAnchor.constraint(equalTo: imageView.topAnchor),
                insideView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                insideView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                insideView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
                insideView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                imageView.heightAnchor.constraint(equalToConstant: 550),
                imageView.centerYAnchor.constraint(equalTo: outsideView.centerYAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                
                movietitle.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 20),
                movietitle.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: -20),
                movietitle.topAnchor.constraint(equalTo: insideView.topAnchor, constant: 20),
                movietitle.centerXAnchor.constraint(equalTo: insideView.centerXAnchor),
                
                castMembers.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 20),
                castMembers.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: -20),
                castMembers.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
                castMembers.centerXAnchor.constraint(equalTo: insideView.centerXAnchor),
                
                genreLabel.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 10),
                genreLabel.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: -10),
                genreLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
                genreLabel.centerXAnchor.constraint(equalTo: insideView.centerXAnchor),
                overviewLabel.leadingAnchor.constraint(equalTo: insideView.leadingAnchor, constant: 20),
                overviewLabel.trailingAnchor.constraint(equalTo: insideView.trailingAnchor, constant: -20),
                overviewLabel.topAnchor.constraint(equalTo: castMembers.bottomAnchor, constant: 30),
                overviewLabel.centerXAnchor.constraint(equalTo: insideView.centerXAnchor),
                
                dateLabel.topAnchor.constraint(equalTo: movietitle.bottomAnchor, constant: 10),
                dateLabel.centerXAnchor.constraint(equalTo: insideView.centerXAnchor),
                
                likeButton.bottomAnchor.constraint(equalTo: insideView.bottomAnchor, constant: -40),
                likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                likeButton.heightAnchor.constraint(equalToConstant: 80),
                likeButton.widthAnchor.constraint(equalToConstant: 80)
            ])
    }
        
    init(movie: MovieEntity) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        self.configure(with: movie)
        likeButton.isSelected = movieInDB(movietocheck: movie)
    
        Task {
            await loadCastData()
            updateUI()
        }
    }
    
    private func updateLikeButtonState() {
        let config = UIImage.SymbolConfiguration(pointSize: 70, weight: .medium, scale: .default)
        
        if movieInDB(movietocheck: movie) {
            likeButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: config), for: .selected)
        } else {
            likeButton.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        }
    }
    
    func loadCastData() async{
        let castmembers = await movieAPI.getMovieCast(movieId: movie.id!)
        cast = (castmembers?.map { $0.name })!
        cast = Array(cast.prefix(6))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        updateLikeButtonState()
    }
    
    func updateUI() {
            DispatchQueue.main.async {
                self.configure(with: self.movie)
                self.castMembers.text = "\(self.cast.joined(separator: ", ")) ..."
            }
        }
    
    public func configure(with movie: MovieEntity) {
        
        movietitle.text = movie.title?.uppercased()
        castMembers.text = self.cast.joined(separator: ", ")
        overviewLabel.text = movie.overview
        dateLabel.text = movie.releaseDate
        
        let reversedGenresDictionary = Dictionary(uniqueKeysWithValues: movieAPI.genres.map { ($1, $0) })
        let genreNames = movie.genreIDS!.compactMap { reversedGenresDictionary[$0] }
        genreLabel.text = genreNames.joined(separator: " \u{2022} ")
        
        
        guard let posterPath = movie.posterPath else {
            imageView.image = UIImage(named: "placeholder")
            return
        }
        let fullPosterURL = "https://image.tmdb.org/t/p/w500\(posterPath)"
        if let url = URL(string: fullPosterURL) {
            imageView.sd_setImage(with: url, completed: nil)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
