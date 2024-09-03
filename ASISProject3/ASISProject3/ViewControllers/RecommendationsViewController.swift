//
//  RecommendationsViewController.swift
//  ASISProject3
//
//  Created by Armağan Gül on 25.08.2024.
//
import UIKit
class RecommendationsViewController: UIViewController {
    private var tableView = UITableView()
    private var movieAPI = MovieAPI()
    private lazy var viewModel = RecommendationsViewModel(service: movieAPI, delegate: self)
    private var movies: [MovieEntity] = []
    private var likes = LikesViewController()
    let dataController = DataController.shared

       override func viewDidLoad() {
           super.viewDidLoad()
           tableView.backgroundColor = UIColor(red: 0/255, green: 25/255, blue: 51/255, alpha: 1.0)
           Task {
               await viewModel.getData()
           }
           setupUI()
       }
    
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecommendationsTableViewCell.self, forCellReuseIdentifier: RecommendationsTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)

        
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalTo: view.topAnchor),
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
             tableView.rightAnchor.constraint(equalTo: view.rightAnchor),])
    }
    
    func fetchAllMovies() -> [LikedMovie] {
        return dataController.fetchLikedMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await viewModel.getData()
            tableView.reloadData()
        }
    }
}

extension RecommendationsViewController: RecommendationsViewModelDelegate {
    func didGet(data: [MovieEntity]) {
        
        let likedMovies = fetchAllMovies()
        let likedMovieIDs = likedMovies.map { $0.likedmovieid }
        let selectedMovies = data.filter { movie in
            likedMovieIDs.contains(Int64(movie.id!))
        }
        Task {
            var allRecommendations: [MovieEntity] = []
            for movie in selectedMovies {
                if let recommendations = await movieAPI.getRecommendedMovies(movieId: movie.id!) {
                    let limitedRecommendations = Array(recommendations.prefix(3))
                    allRecommendations.append(contentsOf: limitedRecommendations)
                }
            }
            
            DispatchQueue.main.async {
                self.movies = allRecommendations
                self.tableView.reloadData()
            }
        }
    }
}

extension RecommendationsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationsTableViewCell.identifier, for: indexPath) as! RecommendationsTableViewCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        let detailViewController = ExploreDetailViewController(movie: selectedMovie)
        present(detailViewController, animated: true)
    }
}



