//
//  LoginViewController.swift
//  instagram
//
//  Created by Tiffany Madruga on 6/27/17.
//  Copyright © 2017 Tiffany Madruga. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

   
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signIn(_ sender: Any) {
        
        
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!){(user: PFUser?, error: Error?) in
            
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
            
        }
    }
        
    
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground{ (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Yay! Created a user!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // manually segue to logged in view
            }
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
