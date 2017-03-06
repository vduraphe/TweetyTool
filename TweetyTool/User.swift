//
//  User.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 2/26/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    var dictionary: NSDictionary?
    var bannerUrl: URL?
    var followerCount: Int?
    var followingCount: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        let bannerImageString = dictionary["profile_background_image_url_https"] as? String
        if bannerImageString != nil {
            bannerUrl = URL(string: bannerImageString!)!
        }
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        
        tagline = dictionary["description"] as? String
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
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    

}
