//
//  BadgesViewController.swift
//  DeBias
//
//  Created by Leslie Kurt on 12/2/16.
//  Copyright © 2016 debias. All rights reserved.
//


import UIKit

class BadgesViewController: UICollectionViewController{
        
    //@IBOutlet weak var collectionView: UICollectionView!
    
    var badges = [Badge]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBadges()
        //self.collectionView?.reloadData()
        //self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initBadges()
    {
        let badge1 = Badge(title: "Read 5 Conservative Articless", completed: true, backgroundCircle: UIImage(named: "red-circle.png")!)!
        let badge2 = Badge(title: "Read 5 Liberal Articles", completed: true, backgroundCircle: UIImage(named: "blue-circle.png")!)!
        let badge3 = Badge(title: "Read 5 Neutral Articles", completed: true, backgroundCircle: UIImage(named: "purple-circle.png")!)!
        let badge4 = Badge(title: "Read 10 Neutral Articles", completed: false, backgroundCircle: UIImage(named: "gray-circle.png")!)!
        let badge5 = Badge(title: "Read Equal Liberal And Conservative", completed: false, backgroundCircle: UIImage(named: "gray-circle.png")!)!
        let badge6 = Badge(title: "#1 in Diversity Ranking", completed: false, backgroundCircle: UIImage(named: "gray-circle.png")!)!
        let badge7 = Badge(title: "#1 in Articles Read Ranking", completed: false, backgroundCircle: UIImage(named: "gray-circle.png")!)!
        let badge8 = Badge(title: "#1 in Both Rankings", completed: false, backgroundCircle: UIImage(named: "gray-circle.png")!)!
        badges += [badge1, badge2, badge3, badge4, badge5, badge6, badge7, badge8]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let identifier="BadgesCollectionViewCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! BadgesCollectionViewCell
        cell.titleLabel.text = badges[indexPath.row].title
        cell.backgroundCircle.image = badges[indexPath.row].backgroundCircle
        if (badges[indexPath.row].completed)
        {
            cell.trophyImage.image = UIImage(named: "trophy.png")
        }
        else
        {
             cell.trophyImage.image = UIImage(named: "trophy-b-and-w.png")
        }
//
    return cell
    }
    
}

