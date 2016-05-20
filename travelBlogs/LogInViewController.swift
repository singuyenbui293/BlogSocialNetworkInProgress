//
//  ViewController.swift
//  travelBlogs
//
//  Created by admin on 5/19/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
  
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func LoginButton(sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    self.alertMessage("Error", message: "")
                    
                } else {
                    print(user)
                    print("User logged in")
                    self.performSegueWithIdentifier("newFeed", sender: self)
                }
            })
        } else {
            alertMessage("Oops", message: "PLease fill all the fields")
        }
        
    }
    
    @IBAction func SignUpButton(sender: UIButton) {
        
    }
    
    func alertMessage (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OK = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alert.addAction(OK)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

