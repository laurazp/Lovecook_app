//
//  CoreDataPersistenceController.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 30/12/23.
//

import CoreData

class CoreDataPersistenceController/*: ObservableObject*/ {
    static let shared = CoreDataPersistenceController()
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "Lovecook")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        do {
            try viewContext.save()
            print("Favorite saved!")
        } catch {
            viewContext.rollback()
            print("Whoops, something went wrong... \(error.localizedDescription)")
        }
    }
    
    func getAllFavorites() -> [CDFavoriteRecipe] {
        let request = NSFetchRequest<CDFavoriteRecipe>(entityName: "CDFavoriteRecipe")

        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func addRecipeToFavorites(recipe: Recipe) {
        let newFavorite = CDFavoriteRecipe(context: viewContext)
        newFavorite.title = recipe.recipeTitle
        newFavorite.id = recipe.recipeId
        newFavorite.image = recipe.recipeImage
        
        saveContext()
        
        //TODO: es lo mismo? si lo es, añadir do catch!!
        /*do {
            try viewContext.save()
        } catch {
            // Replace this implementation to handle the error appropriately
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }*/
    }
    
    func deleteFavorite(recipe: Recipe) {
        let favoriteToDelete = CDFavoriteRecipe(context: viewContext)
        favoriteToDelete.title = recipe.recipeTitle
        favoriteToDelete.id = recipe.recipeId
        favoriteToDelete.image = recipe.recipeImage
        
        viewContext.delete(favoriteToDelete)
        
        saveContext()
    }
}
