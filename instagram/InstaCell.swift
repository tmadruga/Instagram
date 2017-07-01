//
//  InstaCell.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/28/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstaCell: UITableViewCell {
    
    
    @IBOutlet weak var feedPhoto: PFImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var feedCaptionLabel: UILabel!
    
    @IBOutlet weak var profilePicture: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.feedPhoto.file = instagramPost["media"] as? PFFile
            self.feedPhoto.loadInBackground()
        }
    }
    
    var userProfilePicture: PFObject! {
        didSet {
            self.feedPhoto.file = instagramPost["media"] as? PFFile
            self.feedPhoto.loadInBackground()
        }
    }


   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
