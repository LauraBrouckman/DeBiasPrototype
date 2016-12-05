//
//  User.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/20/16.
//  Copyright © 2016 debias. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {
    
    class func addUserToDB(name: String, friend: Bool, canSeeArticles: Bool, picture_filename: String, diversity: Float, articles: Array<Article>, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        let request = NSFetchRequest(entityName: "User")
        request.predicate = NSPredicate(format: "name = %@", name)
        
        /*If the user already is in the database then just return the user object */
        if let result = (try? context.executeFetchRequest(request))?.first as? User {
            
            /* If the user exists, add any articles to the user that aren't already there */
            if result.articles != nil {
                for article in articles {
                    if !result.articles!.containsObject(article) { //does not contain tweetID
                        result.articles = result.articles!.setByAddingObject(article)
                    }
                }
            }
            return result
        }
        /*Otherwise create a new user with the given parameters and return it*/
        else if let result = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as? User {
            result.name = name
            result.friend = friend
            result.articles = NSSet(array: articles)
            result.canSeeArticles = canSeeArticles
            result.picture_filename = picture_filename
            result.numArticles = articles.count
            result.diversity = diversity
            return result
        }
        return nil
    }
    
    /* Change a user's friend status */
    class func changeFriendStatusOfUser(name: String, friend: Bool, inManagedObjectContext context: NSManagedObjectContext) -> User? {
        let request = NSFetchRequest(entityName: "User")
        request.predicate = NSPredicate(format: "name = %@", name)
        
        /* If the user's name is in the DB, change the friend status and return the new User object*/
        if let result = (try? context.executeFetchRequest(request))?.first as? User {
            result.friend = friend
            return result
        }
        /* otherwise do nothing and return nil */
        return nil
    }
}
