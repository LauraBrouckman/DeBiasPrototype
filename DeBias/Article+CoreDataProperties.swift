//
//  Article+CoreDataProperties.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 12/6/16.
//  Copyright © 2016 debias. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Article {

    @NSManaged var author: String?
    @NSManaged var source: String?
    @NSManaged var title: String?
    @NSManaged var type: String?
    @NSManaged var typeExplanation: String?
    @NSManaged var url: String?
    @NSManaged var imageFile: String?
    @NSManaged var users: NSSet?

}
