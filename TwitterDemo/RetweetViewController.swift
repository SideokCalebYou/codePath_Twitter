//
//  RetweetViewController.swift
//  TwitterDemo
//
//  Created by sideok you on 4/16/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class RetweetViewController: UIViewController {

  @IBOutlet weak var tweetTextField: UITextField!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  
  
  var userId: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      TwitterClient.sharedInstance?.currentAccount(succues: { (user:User) in
        
        self.screenNameLabel.text = user.screenName
        self.userNameLabel.text = user.name
        self.profileImageView.setImageWith(user.profileUrl!)
        
      }, failure: { (error:Error) in
        
      })
      
      
        // Do any additional setup after loading the view.
    }

  @IBAction func onBackButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onTweetButton(_ sender: Any) {
    
    TwitterClient.sharedInstance?.reTweetFromTheTweet(tweetText: tweetTextField.text!, statusId: userId!, success: {
      
      print("retweet success!!")
    }, failure: { (error:Error) in
      print("fail to retweet")
    })
    
    dismiss(animated: true, completion: nil)
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
