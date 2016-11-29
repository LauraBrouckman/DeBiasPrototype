//
//  UserDefaults.swift
//  AlarmCharm
//

import Foundation

/* This class has all the user defaults functionality for interacting with NSUserDefaults.
 User Defaults is used to store information about the current user, including their username, login info, any settings they have, their goals, the number of
 each type of article they read and an array of article names (the article info themselves is stored in CoreData)
 */

class UserDefaults{
    
    static var usernameKey                  = "username"
    static var passwordKey                  = "passwordKey"
    
    static var veryConservativeGoalKey      = "veryConservativeGoalKey"
    static var conservativeGoalKey          = "conservativeGoalKey"
    static var neutralGoalKey               = "neutralGoalKey"
    static var liberalGoalKey               = "liberalGoalKey"
    static var veryLiberalGoalKey           = "veryLiberalGoalKey"
    
    static var veryConservativeReadKey      = "veryConservativeReadKey"
    static var conservativeReadyKey         = "conservativeReadyKey"
    static var neutralReadKey               = "neutralReadKey"
    static var liberalReadKey               = "liberalReadKey"
    static var veryLiberalReadKey           = "veryLiberalReadKey"
    
    static var veryConservativeArticles     = "veryConservativeArticles"
    static var conservativeArticles         = "conservativeArticles"
    static var neutralArticles              = "neutralArticles"
    static var liberalArticles              = "liberalArticles"
    static var veryLiberalArticles          = "veryLiberalArticles"
    
    static var firstWeekKey                 = "week1Articles"
    static var secondWeekKey                = "week2Articles"
    static var thirdWeekKey                 = "week3Articles"
    static var weekKeys                            = [firstWeekKey, secondWeekKey, thirdWeekKey]

    static var articleTypes = ["veryConservative", "conservative", "neutral", "liberal", "veryLiberal"]
    
    /* Get and set basic fields like username and password */
    static func setUsername(newUsername: String) {
        NSUserDefaults.standardUserDefaults().setValue(newUsername, forKey: usernameKey)
    }
    
    static func getUsername() -> String? {
        return NSUserDefaults.standardUserDefaults().valueForKey(usernameKey) as? String
    }
    
    static func setPassword(newPassword: String) {
        NSUserDefaults.standardUserDefaults().setValue(newPassword, forKey: passwordKey)
    }
    
    static func getPassword() -> String? {
        return NSUserDefaults.standardUserDefaults().valueForKey(passwordKey) as? String
    }
    
    /*Get and set article goals, passed in is the articleType which is veryConservative, conservative, neutral, liberal, veryLibersl */
    static func setArticleGoal(newGoal: Int, articleType: String) {
        switch articleType{
        case "veryConservative":
            NSUserDefaults.standardUserDefaults().setValue(newGoal, forKey: veryConservativeGoalKey)
        case "conservative":
            NSUserDefaults.standardUserDefaults().setValue(newGoal, forKey: conservativeGoalKey)
        case "neutral":
            NSUserDefaults.standardUserDefaults().setValue(newGoal, forKey: neutralGoalKey)
        case "liberal":
            NSUserDefaults.standardUserDefaults().setValue(newGoal, forKey: liberalGoalKey)
        case "veryLiberal":
            NSUserDefaults.standardUserDefaults().setValue(newGoal, forKey: veryLiberalGoalKey)
        default: break
        }
    }
    
    static func getArticleGoal(articleType: String) -> Int? {
        
        switch articleType{
        case "veryConservative":
            return NSUserDefaults.standardUserDefaults().valueForKey(veryConservativeGoalKey) as? Int
        case "conservative":
            return NSUserDefaults.standardUserDefaults().valueForKey(conservativeGoalKey) as? Int
        case "neutral":
            return NSUserDefaults.standardUserDefaults().valueForKey(neutralGoalKey) as? Int
        case "liberal":
            return NSUserDefaults.standardUserDefaults().valueForKey(liberalGoalKey) as? Int
        case "veryLiberal":
            return NSUserDefaults.standardUserDefaults().valueForKey(veryLiberalGoalKey) as? Int
        default:
            return nil
        }
    }
    
    /*Get and set the NUMBER of articles read, passed in is the articleType which is veryConservative, conservative, neutral, liberal, veryLibersl */
    static func setArticleRead(newValue: Int, articleType: String) {
        switch articleType{
        case "veryConservative":
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: veryConservativeReadKey)
        case "conservative":
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: conservativeReadyKey)
        case "neutral":
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: neutralReadKey)
        case "liberal":
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: liberalReadKey)
        case "veryLiberal":
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: veryLiberalReadKey)
        default: break
        }
    }
    
    static func getArticleRead(articleType: String) -> Int? {
        
        switch articleType{
        case "veryConservative":
            return NSUserDefaults.standardUserDefaults().valueForKey(veryConservativeReadKey) as? Int
        case "conservative":
            return NSUserDefaults.standardUserDefaults().valueForKey(conservativeReadyKey) as? Int
        case "neutral":
            return NSUserDefaults.standardUserDefaults().valueForKey(neutralReadKey) as? Int
        case "liberal":
            return NSUserDefaults.standardUserDefaults().valueForKey(liberalReadKey) as? Int
        case "veryLiberal":
            return NSUserDefaults.standardUserDefaults().valueForKey(veryLiberalReadKey) as? Int
        default:
            return nil
        }
    }
    
    /*Add an article (via title) of a certain type to the users list */
    static func addArticleToList(articleName: String, articleType: String) {
        switch articleType{
        case "veryConservative":
            if var prevArticles = NSUserDefaults.standardUserDefaults().valueForKey(veryConservativeArticles) as? Array<String> {
                prevArticles.append(articleName)
                NSUserDefaults.standardUserDefaults().setValue(prevArticles, forKey: veryConservativeArticles)
            } else {
                let articles = [articleName]
                NSUserDefaults.standardUserDefaults().setValue(articles, forKey: veryConservativeArticles)
            }
        case "conservative":
            if var prevArticles = NSUserDefaults.standardUserDefaults().valueForKey(conservativeArticles) as? Array<String> {
                prevArticles.append(articleName)
                NSUserDefaults.standardUserDefaults().setValue(prevArticles, forKey: conservativeArticles)
            } else {
                let articles = [articleName]
                NSUserDefaults.standardUserDefaults().setValue(articles, forKey: conservativeArticles)
            }
        case "neutral":
            if var prevArticles = NSUserDefaults.standardUserDefaults().valueForKey(neutralArticles) as? Array<String> {
                prevArticles.append(articleName)
                NSUserDefaults.standardUserDefaults().setValue(prevArticles, forKey: neutralArticles)
            } else {
                let articles = [articleName]
                NSUserDefaults.standardUserDefaults().setValue(articles, forKey: neutralArticles)
            }
        case "liberal":
            if var prevArticles = NSUserDefaults.standardUserDefaults().valueForKey(liberalArticles) as? Array<String> {
                prevArticles.append(articleName)
                NSUserDefaults.standardUserDefaults().setValue(prevArticles, forKey: liberalArticles)
            } else {
                let articles = [articleName]
                NSUserDefaults.standardUserDefaults().setValue(articles, forKey: liberalArticles)
            }
        case "veryLiberal":
            if var prevArticles = NSUserDefaults.standardUserDefaults().valueForKey(veryLiberalArticles) as? Array<String> {
                prevArticles.append(articleName)
                NSUserDefaults.standardUserDefaults().setValue(prevArticles, forKey: veryLiberalArticles)
            } else {
                let articles = [articleName]
                NSUserDefaults.standardUserDefaults().setValue(articles, forKey: veryLiberalArticles)
            }
        default: break
        }
    }
    
    /*Get the list of articles read by the user for a certain type */
    static func getArticleList(articleType: String) -> Array<String>? {
        switch articleType{
        case "veryConservative":
            return  NSUserDefaults.standardUserDefaults().valueForKey(veryConservativeArticles) as? Array<String>
        case "conservative":
            return  NSUserDefaults.standardUserDefaults().valueForKey(conservativeArticles) as? Array<String>
            
        case "neutral":
            return  NSUserDefaults.standardUserDefaults().valueForKey(neutralArticles) as? Array<String>
            
        case "liberal":
            return  NSUserDefaults.standardUserDefaults().valueForKey(liberalArticles) as? Array<String>
            
        case "veryLiberal":
            return  NSUserDefaults.standardUserDefaults().valueForKey(veryLiberalArticles) as? Array<String>
            
        default: return nil
        }
    }
    
    /* Helper function that clears out the article list for a given type */
    static func clearArticleList(articleType: String) {
        switch articleType{
        case "veryConservative":
            let articles = []
            NSUserDefaults.standardUserDefaults().setValue(articles, forKey: veryConservativeArticles)
        case "conservative":
            let articles = []
            NSUserDefaults.standardUserDefaults().setValue(articles, forKey: conservativeArticles)
        case "neutral":
            let articles = []
            NSUserDefaults.standardUserDefaults().setValue(articles, forKey: neutralArticles)
        case "liberal":
            let articles = []
            NSUserDefaults.standardUserDefaults().setValue(articles, forKey: liberalArticles)
        case "veryLiberal":
            let articles = []
            NSUserDefaults.standardUserDefaults().setValue(articles, forKey: veryLiberalArticles)
        default: break
        }
    }
    
    /* Clear articles read (done at the end of each week) removes all articles from the lists and sets num articles read to 0 for each category */
    static func clearArticles() {
        for type in articleTypes {
            setArticleRead(0, articleType: type)
            clearArticleList(type)
        }
    }
    
    static func setLongTermData(data: [Dictionary<String, Int>]) {
        for i in 0 ..< 3  {
            NSUserDefaults.standardUserDefaults().setValue(data[i], forKey: weekKeys[i])
        }
    }
    
    static func getAllLongTermData() -> [Dictionary<String, Int>]{
        var data = [Dictionary<String, Int>]()
        for i in 0..<3 {
            data.append((NSUserDefaults.standardUserDefaults().valueForKey(weekKeys[i]) as? Dictionary<String, Int>)!)
        }
        return data
    }
    
    static func getLongTermData(forWeek week: Int) -> Dictionary<String, Int>! {
        return NSUserDefaults.standardUserDefaults().valueForKey(weekKeys[week]) as? Dictionary<String, Int>
    }
    
}




