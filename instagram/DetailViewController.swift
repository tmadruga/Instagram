//
//  DetailViewController.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/29/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    

    
    @IBOutlet weak var detailPhoto: PFImageView!
    @IBOutlet weak var detailUsernameLabel: UILabel!
    @IBOutlet weak var likesDetailLabel: UILabel!
    @IBOutlet weak var captionDetailLabel: UILabel!
    @IBOutlet weak var timestampDetailLabel: UILabel!
    var postDetail: PFObject!
    var instagramPost: PFObject! {
        didSet {
            self.detailPhoto.file = instagramPost["media"] as? PFFile
            self.detailPhoto.loadInBackground()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let postDetail = postDetail{
            let author = postDetail["author"] as? PFUser
            let username = author?.username
            if let date = postDetail.createdAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .short
                let dateString = dateFormatter.string(from: date)
                timestampDetailLabel.text = dateString
            }
            
            if postDetail["caption"] == nil{
                captionDetailLabel.text = "\(" ")"
            }else{
                captionDetailLabel.text = "\(postDetail["caption"]!)"
            }
            detailUsernameLabel.text = username
            likesDetailLabel.text = "\(postDetail["likesCount"]!)"
            instagramPost = postDetail
        
        }

        // Do any additional setup after loading the view.
    }

    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
