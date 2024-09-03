//
//  DataController.swift
//  ASISProject3
//
//  Created by Armağan Gül on 31.08.2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    static let shared = DataController()
    
    private var persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "LikedMovies")
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error: \(error.localizedDescription)")
            }
        }
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
    
    func saveMovieEntity(movieid: Int64) -> Bool {
        let movieEntity = LikedMovie(context: viewContext)
        movieEntity.likedmovieid = movieid
        do {
            try viewContext.save()
            return true
        } catch {
            print("Failed to save MovieEntity: \(error.localizedDescription)")
            return false
        }
    }
    
    // Fetch all liked movies
    func fetchLikedMovies() -> [LikedMovie] {
        let fetchRequest: NSFetchRequest<LikedMovie> = LikedMovie.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch liked movies: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteMovieEntity(movieid: Int64) {
        let fetchRequest: NSFetchRequest<LikedMovie> = LikedMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "likedmovieid == %d", movieid)
        
        do {
            let movies = try viewContext.fetch(fetchRequest)
            if let movie = movies.first {
                viewContext.delete(movie)
                try viewContext.save()
            }
        } catch {
            print("Failed to delete MovieEntity: \(error.localizedDescription)")
        }
    }
}
    
    

