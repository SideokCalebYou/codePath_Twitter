//
//  SelectTweetViewController.swift
//  TwitterDemo
//
//  Created by sideok you on 4/16/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class SelectTweetViewController: UIViewController {

  @IBOutlet weak var favCountLabel: UILabel!
  @IBOutlet weak var tweetCountLabel: UILabel!
  @IBOutlet weak var timestampLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  
  var favCountInt:Int = 0
  var tweetCountInt:Int = 0
  var timestampString:String = ""
  var tweetTextString:String = ""
  var screenNameString:String = ""
  var profileImageUrl:URL!
  var userNameString:String = ""
  var userId: String = ""
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
        favCountLabel.text = String(favCountInt)
        tweetCountLabel.text = String(tweetCountInt)
        timestampLabel.text = timestampString
        tweetTextLabel.text = tweetTextString
        screenNameLabel.text = screenNameString
        profileImageView.setImageWith(profileImageUrl)
        userNameLabel.text = userNameString
    

        // Do any additional setup after loading the view.
    }
 
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
      if let nc = segue.destination as? UINavigationController{
        let vc = nc.topViewController as! RetweetViewController
        
        vc.userId = self.userId
      }
  }
  
  @IBAction func onHomeButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func onReplayButton(_ sender: Any) {
    
    
  }
  
  @IBAction func onRetweetButton(_ sender: Any) {
    
    TwitterClient.sharedInstance?.retweet(tweetId: userId, success: { 
      
      print("retweet updated")
      
    }, failure: { (error:Error) in
      
    })
  }
  
  @IBAction func onFavButton(_ sender: Any) {
    
    TwitterClient.sharedInstance?.favorite(tweetId: userId, success: { 
      print("favorite added")
    }, failure: { (error:Error) in
      
    })
  }
  
  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}
