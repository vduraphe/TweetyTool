//
//  User.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 2/26/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: Int = 0
    var name: String
    var screenname: String
    //var profileUrl: URL?
    var tagline: String
    
    var dictionary: NSDictionary
    var followerCount: Int = 0
    var userImageURL: URL
    var bannerImageURL: URL?
    var followersString: String {
        return countText(count: followerCount)
    }
    var tweetCount: Int = 0
    var followingCount: Int = 0
    var followingString: String {
        return countText(count: followingCount)
    }
    var tweetsString: String {
        return countText(count: tweetCount)
    }

    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String
        screenname = dictionary["screen_name"] as! String
        userImageURL = URL(string: dictionary["profile_image_url_https"] as! String)!
       bannerImageURL = URL(string: dictionary["profile_banner_url"] as? String ?? "")
        tagline = dictionary["description"] as! String
        followingCount = dictionary["friends_count"] as! Int
        followerCount = dictionary["followers_count"] as! Int
        tweetCount = dictionary["statuses_count"] as! Int
        
        
        //name = dictionary["name"] as? String
        //screenname = dictionary["screen_name"] as? String
        //profileUrl = URL(string: dictionary["profile_image_url_https"] as! String)!
       
   
 
    }
    
    static let userDidLogoutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let data = defaults.object(forKey: "currentUserData") as? Data
                if let data = data {
                    let dictionary = try! JSONSerialization.jsonObject(with: data, options: [])
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    func countText(count: Int) -> String {
        if count >= 1000000 {
            return "\(Double(count/100000).rounded()/10) M"
        } else if count >= 1000 {
            return "\(Double(count/100).rounded()/10) K"
        } else {
            return "\(count)"
        }
    }
    

}
