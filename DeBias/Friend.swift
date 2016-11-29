//
//  Created by Leslie Kurt on 11/21/16.
//
//

import UIKit

class Friend
{
    var name: String
    var numArticles: Int
    var articles: Array<Int>
    var profilePic: UIImage?
    var diversity: Float
    
    init?(name: String, profilePic: UIImage?, articles: Array<Int>)
    {
        self.name = name
        self.articles = articles
        self.profilePic = profilePic
        self.numArticles = 0
        self.diversity = 0
        
        getNumArticles(articles)
        getDiversity(articles)
        if name.isEmpty
        {
            return nil
        }
    }
    
    func getNumArticles(articles: Array<Int>)
    {
        var totalArticles = 0
        for i in 0..<articles.count {
            totalArticles += articles[i]
        }
        self.numArticles = totalArticles
    }

    func getDiversity(articles: Array<Int>)
    {
        let mean = Float(Float(self.numArticles) / 5)
        var variation = Float(0.0)
        for i in 0..<articles.count {
            variation += Float(pow(mean - Float(articles[i]), 2))
        }
        self.diversity = variation / 5
    }
}

