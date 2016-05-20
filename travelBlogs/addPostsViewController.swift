//
//  addPostsViewController.swift
//  travelBlogs
//
//  Created by admin on 5/19/16.
//  Copyright © 2016 NguyenBui. All rights reserved.
//

import UIKit
import Firebase

class addPostsViewController: UIViewController {
    var ref =  FIRDatabase.database().reference()
    var userName = ""
    var uid = ""
    
    @IBOutlet weak var PostTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("users").child(userID!).observeEventType(.Value, withBlock: { (snapshot) in
            let username = snapshot.value!["username"] as! String
            self.userName = username
            self.uid = userID!
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Do any additional setup after loading the view.
    }

    
    
    
    @IBAction func post(sender: AnyObject) {
        if let post = PostTextField.text {
            
            let newPost: Dictionary<String, AnyObject> = [
                "Post Text": post,
                "author": userName,
                "uid"   : uid
            ]
            

            ref.child("posts").childByAutoId().setValue(newPost)
        }
        dismissViewControllerAnimated(true, completion: nil)
        print(ref.child("posts").childByAutoId().key)
    }
    
    @IBAction func cancel(sender: AnyObject) {
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
