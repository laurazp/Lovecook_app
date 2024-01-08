//
//  CDFavoriteRecipe+CoreDataProperties.swift
//  Lovecook
//
//  Created by Laura Zafra Prat on 31/12/23.
//
//

import Foundation
import CoreData

extension CDFavoriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFavoriteRecipe> {
        return NSFetchRequest<CDFavoriteRecipe>(entityName: "CDFavoriteRecipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?

}

extension CDFavoriteRecipe : Identifiable {

}
