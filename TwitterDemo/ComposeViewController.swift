//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by sideok you on 4/16/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

  @IBOutlet weak var myProfileImage: UIImageView!
  @IBOutlet weak var myNameTextLabel: UILabel!
  @IBOutlet weak var myTweetIdLabel: UILabel!
  @IBOutlet weak var tweetTextField: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    TwitterClient.sharedInstance?.currentAccount(succues: { (user:User) in
      
      self.myProfileImage.setImageWith(user.profileUrl!)
      self.myNameTextLabel.text = user.name
      self.myTweetIdLabel.text = user.screenName
      
      
    }, failure: { (error:Error) in
      
    })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  @IBAction func goBackHome(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onTweetButton(_ sender: Any) {
    var typedText = String()
    
    typedText = tweetTextField.text ?? ""
    print(typedText)
    
    TwitterClient.sharedInstance?.updateTweet(tweetText: typedText, success: { 
        print("updated")
    }, failure: { (error:Error) in
    
    })
    
    dismiss(animated: true, completion: nil)
  }
}
