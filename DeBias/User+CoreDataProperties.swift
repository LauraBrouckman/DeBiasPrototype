//
//  User+CoreDataProperties.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 12/4/16.
//  Copyright © 2016 debias. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var friend: NSNumber?
    @NSManaged var name: String?
    @NSManaged var canSeeArticles: NSNumber?
    @NSManaged var picture_filename: String?
    @NSManaged var diversity: NSNumber?
    @NSManaged var numArticles: NSNumber?
    @NSManaged var articles: NSSet?

}
