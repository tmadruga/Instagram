//
//  NewPostViewController.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/27/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse



class NewPostViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    
    var userImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTakePhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
    }
    
    
    @IBAction func onChooseFromLibrary(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
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
        postImage.image = userImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
   
    
    @IBAction func onPost(_ sender: Any) {
       
        if self.userImage == nil{
            print("Error")
            let networkalertController = UIAlertController(title: "No Photo Uploaded", message: "Please upload an image and try again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            networkalertController.addAction(cancelAction)
            self.present(networkalertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        
            
            
        }else{
        
        Post.postUserImage(image: userImage!, withCaption: captionField.text) { (SuccessBool: Bool, Error:Error?) in

            
            if SuccessBool == true && Error == nil{
                print("Sucess")
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let userVC = mainStoryboard.instantiateViewController(withIdentifier: "UITabBar")
                self.present(userVC, animated: true, completion: nil)
            }
            
            
            else{
                print("Error")
                let networkalertController = UIAlertController(title: "Error trying to Post", message: "Please try again later.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                networkalertController.addAction(cancelAction)
                self.present(networkalertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }

        
            }
        }
 
    }
    }

    

}
