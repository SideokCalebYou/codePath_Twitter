//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by sideok you on 4/15/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
  
  static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "Xc5l8RmonkTc3Zm3wYPIPnVmn", consumerSecret: "6eRBJaImsW7khDAKRVTe8LgDJtOl3DSMXcLiG6tCuxz1pp8rJd")
  
  var loginSuccess: (() -> ())?
  var loginFailure: ((Error) -> ())?
  
  func handleOpenUrl(url:URL){
    
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (access : BDBOAuth1Credential?) in
      print("I got a token!")
      
      self.currentAccount(succues: { (user:User) in
        User.currentUser = user
        self.loginSuccess?()
      }, failure: { (error:Error) in
        self.loginFailure?(error)
      })
      
      
    }, failure: { (error:Error!) in
      print("error \(error.localizedDescription)")
      self.loginFailure?(error)
    })
    

  }
  
  
  func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
    
    get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, response:Any?) in
      
      let dictionaries = response as! [NSDictionary]
      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
      
      success(tweets)
      
    }, failure: { (task:URLSessionDataTask?, error:Error) in
      failure(error)
    })
  }
  
  func currentAccount(succues: @escaping (User) -> (), failure: @escaping (Error) -> ()){
    get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response:Any?) in
      let userDictionary = response as! NSDictionary
      let user = User(dictionary: userDictionary)
      
      succues(user)
      
      
    }, failure: { (task:URLSessionDataTask?, error:Error) in
      failure(error)
    })
  }
  
  func updateTweet(tweetText: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
    post("/1.1/statuses/update.json", parameters: ["status": tweetText], progress: nil, success: { (_: URLSessionDataTask, resp) -> Void in
      success()
    }, failure: { (task: URLSessionDataTask?, error: Error) in
      failure(error)
      print(error.localizedDescription)
    })
  }
  
  func reTweetFromTheTweet(tweetText: String, statusId: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
    post("/1.1/statuses/update.json", parameters: ["status": tweetText,"in_reply_to_status_id":statusId], progress: nil, success: { (_: URLSessionDataTask, resp) -> Void in
      success()
    }, failure: { (task: URLSessionDataTask?, error: Error) in
      failure(error)
      print(error.localizedDescription)
    })
  }
  
  func favorite(tweetId: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
    post("/1.1/favorites/create.json", parameters: ["id":tweetId], progress:nil, success: { (_: URLSessionDataTask, resp) -> Void in
      success()
    }, failure: {(task:URLSessionDataTask?, error: Error) in
      failure(error)
    })
  }
  
  func retweet(tweetId: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
    
    let retweetUrl = "1.1/statuses/retweet/" + tweetId + ".json"
    post(retweetUrl, parameters: nil, progress:nil, success: { (_: URLSessionDataTask, resp) -> Void in
      success()
    }, failure: {(task:URLSessionDataTask?, error: Error) in
      failure(error)
    })
  }
  

  func login(success: @escaping ()->(), failure: @escaping (Error)->()){
    
    loginSuccess = success
    loginFailure = failure
    
    TwitterClient.sharedInstance?.deauthorize()
    TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"mytwitterdemo://oauth"), scope: nil, success: { (requestToken : BDBOAuth1Credential?) in
      
      if let requestRealToken = requestToken?.token{
        UIApplication.shared.open(URL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestRealToken)")!, options:
          [:], completionHandler: nil)
      }else{
        print("request token not fetched")
      }
      
    }, failure: { (error: Error?) in
      print("error")
      self.loginFailure?(error!)
    })
  }
  
  func logout(){
    User.currentUser = nil
    deauthorize()
    
    NotificationCenter.default.post(name: NSNotification.Name(rawValue:User.userDidLogoutNotification), object: nil)
  }
  
}
