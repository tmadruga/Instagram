//
//  FeedViewController.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/27/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
   

    @IBOutlet weak var feedTableView: UITableView!
    
    var feed: [PFObject]? = []
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        feedTableView.insertSubview(refreshControl, at: 0)
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        fetchFeed()
        
        
        

    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchFeed()
    }
    
    func fetchFeed(){
    
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.feed = posts
                self.feedTableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                print("error")
            }
        }

    
    }
    
    
//    func fetchProfile(){
//        
//        // construct PFQuery
//        let query = PFQuery(className: "Profile")
//        query.order(byDescending: "createdAt")
//        query.includeKey("author")
//        query.whereKey("author", equalTo: PFUser.current())
//        
//        // fetch data asynchronously
//        query.getFirstObjectInBackground { (profiles: PFObject?, error: Error?) in
//            if let profiles = profiles {
//                
//            } else {
//                print("error")
//            }
//        }
//        
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feed!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstaCell", for: indexPath) as! InstaCell
        let post = feed![indexPath.row]
        
        let author = post["author"] as? PFUser
        let username = author?.username
        cell.usernameLabel.text = username
        if post["caption"] == nil{
            cell.feedCaptionLabel.text = "\(" ")"
        }else{
        
            cell.feedCaptionLabel.text = "\(username!): \(post["caption"]!)"
        }
        cell.likesLabel.text = "\(post["likesCount"]!)"
        cell.instagramPost = post
        
        
        
        
        
        
        
        return cell
        
    }
    

        // Do any additional setup after loading the view.
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cellSegue"{
            let newcell = sender as! UITableViewCell
            if let IndexPath = feedTableView.indexPath(for: newcell){
                let onepost = feed![IndexPath.row]
                let DetailViewController = segue.destination as! DetailViewController
                DetailViewController.postDetail = onepost
        
        }
        
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            print("user has logged out")
//            self.dismiss(animated: true, completion: nil)
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let userVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(userVC, animated: true, completion: nil)
            
        }
        
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

