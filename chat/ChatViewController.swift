//
//  ChatViewController.swift
//  chat
//
//  Created by Martene Mendy on 7/28/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

   @IBOutlet weak var chatTableView: UITableView!
   @IBOutlet weak var messageTextField: UITextField!
   var msgs = [PFObject]()

   let messageKey = "key"

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.

      chatTableView.delegate = self
      chatTableView.dataSource = self
      queryMessage()
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.msgs.count
   }


   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

      let cell = chatTableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatViewCell

      let msg = msgs[indexPath.row]
      cell.messageLabel.text = msg.valueForKey(messageKey) as? String
      print(" row \(msg)")
      return cell
   }

   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

   @IBAction func onSend(sender: AnyObject) {

      let mesg = messageTextField.text!
      print("sending message... \(mesg)")

      let msg = PFObject(className:"Message_iOSFeb2016")
      msg[messageKey] = mesg
      msg.saveInBackgroundWithBlock {
         (success: Bool, error: NSError?) -> Void in
         if (success) {
            // The object has been saved.
            print("The object has been saved")
            self.messageTextField.text = ""
            self.queryMessage()
         } else {
            // There was a problem, check error.description
            print("There was a problem, check error.description")
         }
      }
   }

   func queryMessage(){
      let query = PFQuery(className:"Message_iOSFeb2016")
      query.whereKeyExists(messageKey)
      query.findObjectsInBackgroundWithBlock {
         (objects: [PFObject]?, error: NSError?) -> Void in

         if error == nil {
            // The find succeeded.
            print("Successfully retrieved \(objects!.count) scores.")
            // Do something with the found objects
            if let objects = objects {

               self.msgs = objects

               self.chatTableView.reloadData()
               for object in objects {
                  print(object.objectId)
               }
            }
         } else {
            // Log details of the failure
            print("Error: \(error!) \(error!.userInfo)")
         }
      }
   }
}
