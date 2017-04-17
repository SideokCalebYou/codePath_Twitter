//
//  Tweet.swift
//  TwitterDemo
//
//  Created by sideok you on 4/15/17.
//  Copyright © 2017 sideok. All rights reserved.
//

import UIKit

class Tweet: NSObject {

  var text : String?
  var timestampDate : String?
  var timestamp: Date?
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  var profileImageUrl: URL?
  var userName : String?
  var screenName : String?
  var idString : String?
  
  init(dictionary: NSDictionary){
    
    text = dictionary["text"] as? String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
    
    let timestampString = dictionary["created_at"] as? String
    
    let users = dictionary["user"] as! NSDictionary
    userName = users["name"] as? String
    
    idString = (dictionary["id_str"] as? String) ?? ""
    
    if let profileImageUrlString = users["profile_image_url_https"] as? String{
      profileImageUrl = URL(string: profileImageUrlString)
    }else{
      profileImageUrl = nil
    }
    
    screenName = users["screen_name"] as? String
    
    if let timestampString = timestampString {
      let formatter = DateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timestamp = formatter.date(from: timestampString)
      formatter.dateFormat = "MM/dd/yy H:mm a"
      formatter.dateFormat = "MM/dd/yy"
      timestampDate = formatter.string(from: timestamp! as Date)
    }
    
  }
  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
      var tweets = [Tweet]()
    
      for dictionary in dictionaries{
        let tweet = Tweet(dictionary: dictionary)
        tweets.append(tweet)
      }
      
      return tweets
  }
    
}
  

