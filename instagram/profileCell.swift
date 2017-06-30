//
//  profileCell.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/29/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class profileCell: UICollectionViewCell {
    
    @IBOutlet weak var profileCollectionImage: PFImageView!
    
    var instagramPost: PFObject! {
        didSet {
            self.profileCollectionImage.file = instagramPost["media"] as? PFFile
            self.profileCollectionImage.loadInBackground()
        }
    }

    
    
}
