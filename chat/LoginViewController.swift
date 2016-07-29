//
//  ViewController.swift
//  chat
//
//  Created by Martene Mendy on 7/28/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {


   @IBOutlet weak var emailTextField: UITextField!

   @IBOutlet weak var passTextField: UITextField!

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func onSignUp(sender: UIButton) {
      let username = emailTextField.text!
      let password = passTextField.text!

      print("signing up with user \(username)")
      userSignUp(username, passw: password)
   }

   @IBAction func onLogin(sender: UIButton) {
      let username = emailTextField.text!
      let password = passTextField.text!

      print("loging with user \(username)")
      userLogin(username, passw: password)

   }

   func userSignUp(username: String, passw: String) {
      let user = PFUser()
      user.username = username
      user.password = passw
      user.email = username
      // other fields can be set just like with PFObject
      user["phone"] = "555-555-5555"

      user.signUpInBackgroundWithBlock {
         (succeeded: Bool, error: NSError?) -> Void in
         if let error = error {
            let errorString = error.userInfo["error"] as? NSString
            print("error sign up...\(errorString)")
            // Show the errorString somewhere and let the user try again.
            let alertController = UIAlertController(title: "Error signing", message: "Provide credentials are not valid", preferredStyle: .Alert)
            let cancelButton = UIAlertAction(title: "OK", style: .Cancel, handler: {(action) in })
            alertController.addAction(cancelButton)
            //self(alertController, animated: true){}
            self.presentViewController(alertController, animated: true, completion: {})
         } else {
            // Hooray! Let them use the app now.
            print("user sign up!")
         }
      }


   }


   func userLogin(username: String, passw: String){
      PFUser.logInWithUsernameInBackground(username, password:passw) {
         (user: PFUser?, error: NSError?) -> Void in
         if user != nil {
            // Do stuff after successful login.
            print("User logging in...")
            self.performSegueWithIdentifier("loginSegue", sender: nil)

         } else {
            // The login failed. Check error to see why.
            let alertController = UIAlertController(title: "Error Login", message: "Provide credentials are not valid", preferredStyle: .Alert)
            let cancelButton = UIAlertAction(title: "OK", style: .Cancel, handler: {(action) in })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: {})
         }
      }
   }
}

