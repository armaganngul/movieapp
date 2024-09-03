//
//  MovieAPIManager.swift
//  ASISProject3
//
//  Created by Armağan Gül on 25.08.2024.
//

import Foundation

struct MovieAPI{
    let genres: [String: Int] = [
        "Action": 28,
        "Adventure": 12,
        "Animation": 16,
        "Comedy": 35,
        "Crime": 80,
        "Documentary": 99,
        "Drama": 18,
        "Family": 10751,
        "Fantasy": 14,
        "History": 36,
        "Horror": 27,
        "Music": 10402,
        "Mystery": 9648,
        "Romance": 10749,
        "Science Fiction": 878,
        "TV Movie": 10770,
        "Thriller": 53,
        "War": 10752,
        "Western": 37
    ]
    
    func getAPIData(page: Int = 1) async -> [MovieEntity]? {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week")!
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)")  // Add page parameter
            ]
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNDZiZjkxODhhYzg3YjI3OGQ4NDJiN2Q2YjUyZWEzNCIsIm5iZiI6MTcyNDYwODQ5NC43MDU5MDUsInN1YiI6IjY2Y2IzMGIxNDkwOTQzNjAxOTNlYzQxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EKJtl_h5ST3sbb7Re-H2mqn8vXaZR4L-zD4dAKx9WYY"
            ]

            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                return movieResponse.results
            } catch {
                print("Failed to fetch or decode data: \(error)")
                return nil
        }
    }
    
    func getMovieCast(movieId: Int) async -> [CastMember]? {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNDZiZjkxODhhYzg3YjI3OGQ4NDJiN2Q2YjUyZWEzNCIsIm5iZiI6MTcyNDYwODQ5NC43MDU5MDUsInN1YiI6IjY2Y2IzMGIxNDkwOTQzNjAxOTNlYzQxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EKJtl_h5ST3sbb7Re-H2mqn8vXaZR4L-zD4dAKx9WYY"
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let castResponse = try decoder.decode(CastResponse.self, from: data)
            return castResponse.cast
        } catch {
            print("Failed to fetch cast data: \(error)")
            return nil
        }
    }
    
    func getRecommendedMovies(movieId: Int) async -> [MovieEntity]? {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/recommendations")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNDZiZjkxODhhYzg3YjI3OGQ4NDJiN2Q2YjUyZWEzNCIsIm5iZiI6MTcyNDYwODQ5NC43MDU5MDUsInN1YiI6IjY2Y2IzMGIxNDkwOTQzNjAxOTNlYzQxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EKJtl_h5ST3sbb7Re-H2mqn8vXaZR4L-zD4dAKx9WYY"
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let recommendedMovies = try decoder.decode(RecommendedMovies.self, from: data)
            return recommendedMovies.results
        } catch {
            print("Failed to fetch movie data: \(error)")
            return nil
        }
    }
}


