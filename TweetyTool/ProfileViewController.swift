//
//  ProfileViewController.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 3/5/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var followingcount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
  
    var user: User!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(user)
        print(user.userImageURL)
        print(user.bannerImageURL)
        if let bannerImageURL = user.bannerImageURL {
            backgroundImage.setImageWith(bannerImageURL)
        }
        myProfileImageView.setImageWith((user.userImageURL))
        nameLabel.text = user.name
        handleLabel.text = user.screenname
        descriptionLabel.text = user.tagline
        retweetCount.text = user.tweetsString
        followingcount.text = user.followingString
        followersCount.text = user.followersString

        /*
        myProfileImageView.setImageWith(user.userImageURL!)
        nameLabel.text = user.name
        handleLabel.text = user.screenname
        
        
        
        followingcount.text = user.followingString
        followersCount.text = user.followersString
        retweetCount.text = user.tweetsString
 */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Compose segue
        let composeVC = segue.destination as! ComposePageViewController
        composeVC.userReply = "@\(user.screenname)"
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
