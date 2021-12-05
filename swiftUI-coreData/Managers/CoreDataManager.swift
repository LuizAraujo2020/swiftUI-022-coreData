//
//  CoreDataManager.swift
//  swiftUI-coreData
//
//  Created by Luiz Araujo on 05/12/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    /// Responsable for load the Core Data Model, initialize the Core Data Stack
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "HelloCoreDataModel")
        
        /// Load all persistent stores
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data Store failed\(error.localizedDescription )!")
            }
        }
    }
    
    /// How to save a movie
    func saveMovie(title: String) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save the movie \(error.localizedDescription)")
        }
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func DeleteMovie(movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete the movie \(error.localizedDescription)")
        }
    }
    
    func updateMovie() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
    
}

