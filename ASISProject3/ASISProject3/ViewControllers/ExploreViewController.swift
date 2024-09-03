//
//  ExploreViewController.swift
//  ASISProject3
//
//  Created by Armağan Gül on 25.08.2024.
//

import UIKit
import SDWebImage

class ExploreViewController: UIViewController {
    private var images: [UIImage] = []
    private var movies: [MovieEntity] = []
    private var movieAPI = MovieAPI()
    private lazy var viewModel = RecommendationsViewModel(service: movieAPI, delegate: self)
    private var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 7
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: ExploreCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await viewModel.getData()
        }
        
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        self.collectionview.backgroundColor = UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 1.0)

        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(collectionview)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionview.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    func loadImages(from posterPaths: [String]) {
        var imageList: [UIImage] = []
        let dispatchGroup = DispatchGroup()
        
        for path in posterPaths {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(path)") else {
                print("Invalid URL for poster path: \(path)")
                continue
            }
            
            dispatchGroup.enter()
            
            SDWebImageDownloader.shared.downloadImage(with: url) { (image, data, error, finished) in
                if let image = image, finished {
                    imageList.append(image)
                } else if let error = error {
                    print("Failed to download image for URL \(url): \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.images = imageList
            self.collectionview.reloadData() // Reload collection view data
            print("All images have been loaded and collection view reloaded")
        }
    }
}

extension ExploreViewController: RecommendationsViewModelDelegate {
    func didGet(data: [MovieEntity]) {
        DispatchQueue.main.async {
            self.movies = data
            let posterPaths: [String] = self.movies.compactMap { $0.posterPath }
            self.loadImages(from: posterPaths)
        }
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionViewCell.cellIdentifier, for: indexPath) as? ExploreCollectionViewCell else {
            fatalError("Failed to return cell")
        }
        
        let image = self.images[indexPath.row]
        cell.configure(with: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        let detailViewController = ExploreDetailViewController(movie: selectedMovie)
        present(detailViewController, animated: true)
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 147)
    }
}

