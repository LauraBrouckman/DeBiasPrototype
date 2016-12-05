//
//  BadgesCollectionViewCell.swift
//  DeBias
//
//  Created by Leslie Kurt on 12/2/16.
//  Copyright © 2016 debias. All rights reserved.
//


import UIKit

class BadgesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var backgroundCircle: UIImageView!
//    @IBOutlet weak var trophyImage: UIImageView!
    
    @IBOutlet weak var backgroundCircle: UIImageView!
    @IBOutlet weak var trophyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
