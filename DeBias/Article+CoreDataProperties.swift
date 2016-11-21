//
//  Article+CoreDataProperties.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/20/16.
//  Copyright © 2016 debias. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

/* DON'T EDIT THIS FILE, IT WILL BE OVERWRITTEN WHEN YOU REGENERATE COREDATA FILES*/

import Foundation
import CoreData

extension Article {

    @NSManaged var title: String?
    @NSManaged var author: String?
    @NSManaged var source: String?
    @NSManaged var type: String?
    @NSManaged var typeExplanation: String?
    @NSManaged var users: NSSet?

}
