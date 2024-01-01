//
//  CoreDataPersistenceController.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 30/12/23.
//

import CoreData

class CoreDataPersistenceController/*: ObservableObject*/ {
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
            print(error)
            return []
        }
    }
    
    func addRecipeToFavorites(recipe: Recipe) {
        let newFavorite = CDFavoriteRecipe(context: viewContext)
        newFavorite.title = recipe.recipeTitle
        newFavorite.id = recipe.recipeId
        newFavorite.image = recipe.recipeImage
        
        saveContext()
    }
    
    func deleteFavorite(recipe: Recipe) {
        let favoriteToDelete = CDFavoriteRecipe(context: viewContext)
        favoriteToDelete.title = recipe.recipeTitle
        favoriteToDelete.id = recipe.recipeId
        favoriteToDelete.image = recipe.recipeImage
        
        viewContext.delete(favoriteToDelete)
        
        saveContext()
    }
    
    func deleteFavorite(recipe: FavoriteRecipe) {
        let fetchRequest: NSFetchRequest<CDFavoriteRecipe> = CDFavoriteRecipe.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", recipe.id)
            
            do {
                if let favoriteToDelete = try viewContext.fetch(fetchRequest).first {
                    viewContext.delete(favoriteToDelete)
                    saveContext()
                }
            } catch {
                //TODO: Gestionar error ??
                print("Error deleting favorite recipe: \(error)")
            }
    }
}
