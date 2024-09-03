//
//  RecommendationsViewModel.swift
//  ASISProject3
//
//  Created by Armağan Gül on 25.08.2024.
//

import Foundation

struct MovieResponse: Codable {
    
    let page: Int
    let results: [MovieEntity]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieEntity: Codable {
    
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    var adult: Bool = false
    let originalLanguage: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    
    enum CodingKeys: String, CodingKey {
       
        case backdropPath = "backdrop_path"
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct CastResponse: Codable {
    let cast: [CastMember]
}

struct CastMember: Codable {
    let name: String
    let character: String
    let profilePath: String?
}

struct RecommendedMovies: Codable {
    let results: [MovieEntity]
}

struct RecommendationsViewModel{
    var service: MovieAPI
    var delegate: RecommendationsViewModelDelegate
    
    func getData() async {
            var data: [MovieEntity] = []
            var currentPage = 1
            let totalPages = 10

            while currentPage <= totalPages {
                if let movies = await service.getAPIData(page: currentPage) {
                    if movies.isEmpty {
                        break
                    }
                    data.append(contentsOf: movies)
                    currentPage += 1
                } else {
                    break
                }
            }
            
            delegate.didGet(data: data)
        }
}

protocol RecommendationsViewModelDelegate{
    func didGet(data: [MovieEntity])
}


