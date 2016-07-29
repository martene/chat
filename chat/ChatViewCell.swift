//
//  ChatViewCell.swift
//  chat
//
//  Created by Martene Mendy on 7/28/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class ChatViewCell: UITableViewCell {

   @IBOutlet weak var messageLabel: UILabel!


   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }

   override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
   }
}
