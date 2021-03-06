//
//  SignUpViewController.swift
//  travelBlogs
//
//  Created by admin on 5/19/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    var ref =  FIRDatabase.database().reference()
    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func createButton(sender: AnyObject) {
        if let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextfield.text {
            FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    self.alertMessage("Error", message: "\(error?.localizedDescription)")
                } else {
                    print("new User created")
                  
                    self.ref.child("users").child(user!.uid).setValue(["username":  username])
                    
                    FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            print("logged in")
                            self.performSegueWithIdentifier("newFeed2", sender: self)
                        }
                    })
                }
            
            })
        } else {
            alertMessage("Oops", message: "Please fill in all the fields")
        }
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func alertMessage (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OK = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alert.addAction(OK)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
