//
//  ProfileViewController.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 3/5/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var tweet: Tweet!
    var user: User!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        nameLabel.text = tweet.pers.name
        handleLabel.text = tweet.pers.screenname
        myProfileImageView.setImageWith(tweet.pers.profileUrl!)
        backgroundImageView.setImageWith(tweet.pers.bannerUrl!)
        // Dispose of any resources that can be recreated.
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
