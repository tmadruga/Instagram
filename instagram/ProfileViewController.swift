//
//  ProfileViewController.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/29/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var profileCollectionView: UICollectionView!

    @IBOutlet weak var usernamePostText: UILabel!
    
    var feed: [PFObject]? = []
    let User = PFUser.current()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        profileCollectionView.dataSource = self
        usernamePostText.text = User!.username
        
        let layout = profileCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellsPerLine: CGFloat = 3
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = profileCollectionView.frame.size.width/cellsPerLine - interItemSpacingTotal/cellsPerLine
        layout.itemSize = CGSize(width: width, height: width)
        
        
        
        
        
        fetchFeed()

        // Do any additional setup after loading the view.
    }
    
    func fetchFeed(){
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current())
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.feed = posts
                self.profileCollectionView.reloadData()
                //self.refreshControl.endRefreshing()
            } else {
                print("error")
            }
        }
        
        
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(feed!.count)
        return feed!.count
        
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let onepost = feed![indexPath.item]
        let newcell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! profileCell
        let author = onepost["author"] as? PFUser
        newcell.instagramPost = onepost
    
        return newcell
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
