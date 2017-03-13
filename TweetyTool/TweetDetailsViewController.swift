//
//  TweetDetailsViewController.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 3/5/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var myImageLabel: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
   
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        myImageLabel.setImageWith((tweet!.pers.userImageURL))
        nameLabel.text = tweet!.pers.name
        handleLabel.text = "@\(tweet!.pers.screenname)"
        
        tweetText.text = tweet?.text as String?
        
        retweetCount.text = "\(tweet!.retweetCount)"
        favoriteCount.text = "\(tweet!.favoritesCount)"
        
        if tweet?.retweeted == true
        {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        }
        else
        {
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        }
        
        if tweet?.favorited == true
        {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        }
        else
        {
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-1"), for: UIControlState.normal)
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func onReply(_ sender: AnyObject) {
        
    }
    @IBAction func onRetweet(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.retweetTweet(success: { (tweet: Tweet) in
            self.tweet = tweet
            self.retweetCount.text = "\(tweet.retweetCount)"
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            }, failure: { (error: Error) in
                self.unRetweetTweet()
            }, tweetId: (tweet?.id)!)
        
    }
    @IBAction func onFavorite(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.favoriteTweet(success: { (tweet: Tweet) in
            self.tweet = tweet
            self.favoriteCount.text = "\(tweet.favoritesCount)"
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            }, failure: { (error: Error) in
                self.unfavoriteTweet()
            }, tweetId: (tweet?.id)!)
        
    }
    func unfavoriteTweet() {
        
        TwitterClient.sharedInstance?.unfavoriteTweet(success: { (tweet: Tweet) in
            self.tweet = tweet
            self.favoriteCount.text = "\(tweet.favoritesCount)"
            self.favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-1"), for: UIControlState.normal)
            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
            }, tweetId: (tweet?.id)!)
    }
    func unRetweetTweet() {
        
        TwitterClient.sharedInstance?.unRetweetTweet(success: { (tweet: Tweet) in
            self.tweet = tweet
            self.retweetCount.text = "\(tweet.retweetCount - 1)"
            self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
            }, tweetId: (tweet?.id)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if (segue.identifier == "ReplySegue") {
            let indexPathRow = (sender as! UIButton).tag
            let composeVC = segue.destination as! ComposePageViewController
            composeVC.userReply = "@\(tweet.pers.screenname)"
        } else if (segue.identifier == "ProfileSegue") {
            let indexPathRow = (sender as! UIButton).tag
            //let tweet = tweets[indexPathRow];
            
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = tweet.pers
            
        }
        
        
        /*
         if (segue.identifier == "composePage")
         {
         let navVC = segue.destination as! UINavigationController
         let vc = navVC.topViewController as! ComposePageViewController
         vc.profileURL = User.currentUser?.profileUrl
         vc.nameLabel.text = User.currentUser?.name
         vc.handleLabel.text = User.currentUser?.screenname
         }
         */
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
