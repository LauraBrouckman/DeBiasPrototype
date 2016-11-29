//
//  FriendPieChartViewController.swift
//  DeBias
//
//  Created by Leslie Kurt on 11/28/16.
//  Copyright © 2016 debias. All rights reserved.
//



import UIKit

class FriendPieChartViewController: UIViewController
{
    var name = String()
    var profilePic = UIImage()
    var articles = Array<Int>()
    
    @IBOutlet weak var navTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle.title = name
    }
}
