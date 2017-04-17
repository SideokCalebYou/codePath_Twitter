//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by sideok you on 4/15/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var tweetIdLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  
  var tweetData : Tweet!{
    didSet{
      tweetTextLabel.text = tweetData.text
      
      userNameLabel.text = tweetData.userName
      
      profileImage.setImageWith(tweetData.profileImageUrl!)
      
      tweetIdLabel.text = tweetData.screenName
      
      if let since = tweetData.timestamp?.timeIntervalSinceNow {
        let hours = round(since / 3600.0) * -1.0
        if hours < 24 {
          timestampLabel.text = "\(Int(hours))H"
        } else {
          timestampLabel.text = "\(tweetData.timestampDate!)"
        }
      }
    }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
  }
}
