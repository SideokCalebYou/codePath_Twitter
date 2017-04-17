//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by sideok you on 4/15/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var myTweets : [Tweet]!
  var myUsers : User!
  var tweetCount : Int! = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.delegate = self
        tableView.dataSource = self
      
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
      
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) -> () in
          
          self.myTweets = tweets
          
          self.tweetCount = self.myTweets.count
          self.tableView.reloadData()
          
        
        }, failure: { (error:Error) -> () in
        
        })
     
    }
  
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
      TwitterClient.sharedInstance?.homeTimeline(success: { (tweets:[Tweet]) in
        self.myTweets = tweets
        self.tweetCount = self.myTweets.count
        self.tableView.reloadData()
        refreshControl.endRefreshing()
      }, failure: { (error:Error) in
      
      })
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tweetCount
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated:true)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "NewTweetSegue"{
    
    }else{
      
      if let nc = segue.destination as? UINavigationController {
        let vc = nc.topViewController as! SelectTweetViewController
        
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        
        let tweet = self.myTweets[indexPath.row]
        
        vc.favCountInt = tweet.favoritesCount
        vc.profileImageUrl = tweet.profileImageUrl!
        vc.screenNameString = tweet.screenName!
        vc.userNameString = tweet.userName!
        vc.tweetTextString = tweet.text!
        vc.timestampString = tweet.timestampDate!
        vc.tweetCountInt = tweet.retweetCount
        vc.userId = tweet.idString!
      }
    }
  }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
      
      cell.tweetData = self.myTweets[indexPath.row]
      
      return cell
    }
  
  

    @IBAction func onLogoutButton(_ sender: Any) {
      TwitterClient.sharedInstance?.logout()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
