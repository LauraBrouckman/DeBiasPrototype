//
//  Created by Leslie Kurt on 11/21/16.
//
//

import UIKit

class Friend
{
    var name: String
    var numArticles: Int
    var profilePic: UIImage?
    
    init?(name: String, numArticles: Int, profilePic: UIImage?)
    {
        self.name = name
        self.numArticles = numArticles
        self.profilePic = profilePic
        
        if name.isEmpty
        {
            return nil
        }
    }
}

