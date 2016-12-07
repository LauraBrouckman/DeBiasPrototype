//
//  Article.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/20/16.
//  Copyright © 2016 debias. All rights reserved.
//

import Foundation
import CoreData


class Article: NSManagedObject {

    class func addArticleToDB(title: String, author: String, type: String, source: String, typeExplanation: String, url: String, imageFile: String, inManagedObjectContext context: NSManagedObjectContext) -> Article? {
        let request = NSFetchRequest(entityName: "Article")
        request.predicate = NSPredicate(format: "title = %@", title)
        
        /*If the article already is in the database then just return the article object */
        if let result = (try? context.executeFetchRequest(request))?.first as? Article {
            return result
            
        }
        /*Otherwise create a new article with the given parameters and return it*/
        else if let result = NSEntityDescription.insertNewObjectForEntityForName("Article", inManagedObjectContext: context) as? Article {
            result.title = title
            result.author = author
            result.source = source
            result.type = type
            result.typeExplanation = typeExplanation
            result.url = url
            result.imageFile = imageFile
            return result
        }
        return nil
    }
    
    /* Get an article by name, just return nil if the article isn't in the DB */
    class func getArticleByName(title: String, inManagedObjectContext context: NSManagedObjectContext) -> Article? {
        let request = NSFetchRequest(entityName: "Article")
        request.predicate = NSPredicate(format: "title = %@", title)
        
        /*If the article already is in the database then just return the article object */
        if let result = (try? context.executeFetchRequest(request))?.first as? Article {
            return result
            
        }
        return nil
    }
    
}
