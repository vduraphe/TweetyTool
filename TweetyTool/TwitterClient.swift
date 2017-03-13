//
//  TwitterClient.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 2/26/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")! as URL!, consumerKey: "GImli37sd5uqt3imlY410NbeT", consumerSecret: "ZlRdLmsi18E1jzl7ltvLr9TqbNeciaHJ3pgOPmqCI4szcighy0")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?

    func login(success: @escaping ()->(), failure: @escaping (Error)->()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("I got my request token!")
            print(requestToken!.token!)
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            
            UIApplication.shared.open(url, options: [:], completionHandler: { (Bool) in
            })
            }, failure: { (error: Error?) -> Void in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error!)
        })
        
    }
    func logout() {
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil, userInfo: nil)
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (
            accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user:User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: Error) in
                    self.loginFailure!(error)
            })
            
            }, failure: { (error:Error?) in
                print("error: \(error?.localizedDescription)")
                self.loginFailure?(error!);
        })
    }
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task, response) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
            }, failure: { (task, error) in
                failure(error)
        })
    }
    
    func favoriteTweet(success: @escaping (Tweet) -> (), failure: @escaping (Error) -> (), tweetId: Int) {
        post("1.1/favorites/create.json", parameters: ["id": tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func postTweet(success: @escaping () -> (), failure: @escaping (Error) -> (), status: String) {
        post("1.1/statuses/update.json", parameters: ["status": status], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("posted tweet!! \(status)")
            success()
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }

    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error)-> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user);
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })

    }
    
    func unfavoriteTweet(success: @escaping (Tweet) -> (), failure: @escaping (Error) -> (), tweetId: Int) {
        post("1.1/favorites/destroy.json", parameters: ["id": tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            tweet.favorited = false
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    func unRetweetTweet(success: @escaping (Tweet) -> (), failure: @escaping (Error) -> (), tweetId: Int) {
        post("1.1/statuses/unretweet/\(tweetId).json", parameters: ["id": tweetId], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            tweet.retweeted = false
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    }
    
    func retweetTweet(success: @escaping (Tweet) -> (), failure: @escaping (Error) -> (), tweetId: Int) {
        post("1.1/statuses/retweet/\(tweetId).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: dictionary)
            tweet.retweeted = true
            success(tweet)
            
        }) { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        }
    } 
}
