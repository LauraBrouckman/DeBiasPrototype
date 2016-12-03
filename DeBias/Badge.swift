//
//  Badge.swift
//  DeBias
//
//  Created by Leslie Kurt on 12/2/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class Badge
{
    var title: String
    var completed: Bool
    var backgroundCircle: UIImage

    
    init?(title: String, completed: Bool, backgroundCircle: UIImage)
    {
        self.title = title
        self.completed = completed
        self.backgroundCircle = backgroundCircle

    }
    

}

