//
//  TweetCell.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 2/27/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var RTbutton: UIButton!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            myImageView.setImageWith(tweet.pers.profileUrl!)
            nameLabel.text = tweet.pers.name
            handleLabel.text = "@\(tweet.pers.screenname!)"
            
            tweetTextLabel.text = tweet.text as String?
            
            retweetLabel.text = "\(tweet.retweetCount)"
            favoriteLabel.text = "\(tweet.favoritesCount)"
            
            if tweet.retweeted == true
            {
                self.RTbutton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            }
            else
            {
                self.RTbutton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
            }
            
            if tweet.favorited == true
            {
                self.favButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
            }
            else
            {
                self.favButton.setImage(#imageLiteral(resourceName: "favor-icon-1"), for: UIControlState.normal)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.layer.cornerRadius = 4
        myImageView.clipsToBounds = true
    }
    
    @IBAction func onRetweet(_ sender: AnyObject)
    {
        TwitterClient.sharedInstance?.retweetTweet(success: { (tweet: Tweet) in
            self.retweetLabel.text = "\(tweet.retweetCount)"
            self.RTbutton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
            }, failure: { (error: Error) in
                self.unRetweetTweet()
            }, tweetId: tweet.id)
    }

    @IBAction func onFavorite(_ sender: AnyObject)
    {
        
        TwitterClient.sharedInstance?.favoriteTweet(success: { (tweet: Tweet) in
            self.tweet = tweet
            }, failure: { (error: Error) in
                self.unfavoriteTweet()
            }, tweetId: tweet.id)

    }
    func unfavoriteTweet() {
        
        TwitterClient.sharedInstance?.unfavoriteTweet(success: { (tweet: Tweet) in
            self.tweet = tweet
            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
            }, tweetId: tweet.id)
    }
    func unRetweetTweet() {
        
        TwitterClient.sharedInstance?.unRetweetTweet(success: { (tweet: Tweet) in
            self.tweet = tweet
            self.retweetLabel.text = "\(tweet.retweetCount - 1)"

            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
            }, tweetId: tweet.id)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
