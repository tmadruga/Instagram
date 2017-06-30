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

class ProfileViewController: UIViewController, UICollectionViewDataSource, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    @IBOutlet weak var profilePicture: PFImageView!
    
    
    @IBOutlet weak var profileCollectionView: UICollectionView!

    @IBOutlet weak var usernamePostText: UILabel!
    
    var userImage: UIImage?
    
    var feed: [PFObject]? = []
    let User = PFUser.current()
    var prof: PFObject!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        fetchProfile()
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        fetchProfile()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchProfile(){
        
        // construct PFQuery
        let query = PFQuery(className: "Profile")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current())
        
        // fetch data asynchronously
        query.getFirstObjectInBackground { (profiles: PFObject?, error: Error?) in
            if let profiles = profiles {
                self.profilePicture.file = profiles["media"] as? PFFile
                self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
                self.profilePicture.loadInBackground()
            } else {
                print("error")
            }
        }

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
    

    
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func resize(image: UIImage, newsize: CGSize) -> UIImage {
        let resizedImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newsize.width, height: newsize.height))
        resizedImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizedImageView.image = image
        
        UIGraphicsBeginImageContext(resizedImageView.frame.size)
        resizedImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        userImage = resize(image: editedImage, newsize: CGSize(width: 750, height: 750))
        Post.postUserProfile(image: userImage!) { (success: Bool, error: Error?) in
            if success == true && error == nil{
                print("Sucess")
                self.profilePicture.image = self.userImage
                
            }
                
                
            else{
                print("Error")
                let networkalertController = UIAlertController(title: "Error trying to Post", message: "Please try again later.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    
                }
                networkalertController.addAction(cancelAction)
                self.present(networkalertController, animated: true) {
                }
                
                
            }
        }
        dismiss(animated: true, completion: nil)
        
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

