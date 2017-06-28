//
//  FeedViewController.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/27/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {

        // Do any additional setup after loading the view.
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

