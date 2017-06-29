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
    @IBOutlet weak var signinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)
        passwordField.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)
        passwordField.layer.borderColor = UIColor.white.cgColor
        signinButton.backgroundColor = .clear
        signinButton.layer.cornerRadius = 5
        signinButton.layer.borderWidth = 1
        signinButton.layer.borderColor = UIColor.white.cgColor
        

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
                let networkalertController = UIAlertController(title: "Username or Password Incorrect", message: "Please try again.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                networkalertController.addAction(cancelAction)
                self.present(networkalertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }

            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                // display view controller that needs to shown after successful login
            }
            
        }
    }
        
    
    
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground{ (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                let networkalertController = UIAlertController(title: "Username already taken", message: "Please enter and username and password to sign up.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                    // handle cancel response here. Doing nothing will dismiss the view.
                }
                // add the cancel action to the alertController
                networkalertController.addAction(cancelAction)
                self.present(networkalertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
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
