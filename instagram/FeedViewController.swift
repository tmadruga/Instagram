//
//  FeedViewController.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/27/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
   
    

    @IBOutlet weak var feedTableView: UITableView!
    
    var feed: [PFObject]? = []
    
    
    override func viewDidLoad() {
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
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
            } else {
                print("error")
            }
        }

    
    }
    
    
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
        cell.feedCaptionLabel.text = "\(post["caption"]!)"
        }
        cell.likesLabel.text = "\(post["likesCount"]!)"
        cell.instagramPost = post
        
        
        
        
        
        
        return cell
        
    }
    

        // Do any additional setup after loading the view.
    

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

