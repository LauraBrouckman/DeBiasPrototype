//
//  ArticleTableViewCell.swift
//  DeBias
//
//  Created by Elizabeth Brouckman on 11/29/16.
//  Copyright © 2016 debias. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var articlePreviewImage: UIImageView!
    
    var title: String?
    var url: String?
    var type: String?
    var typeExplanation: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
