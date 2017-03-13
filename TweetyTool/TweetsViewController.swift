//
//  TweetsViewController.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 2/26/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let refreshControl: UIRefreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(TweetsViewController.uiRefreshControlAction), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error) in
                print("\(error.localizedDescription)");
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func uiRefreshControlAction()
    {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "tweetDetail")
        {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![(indexPath?.row)!]
            let vc = segue.destination as! TweetDetailsViewController
            vc.tweet = tweet
        } else if (segue.identifier == "ProfileSegue") {
            let indexPathRow = (sender as! UIButton).tag
            let tweet = tweets[indexPathRow];
            
            let profileVC = segue.destination as! ProfileViewController
            profileVC.user = tweet.pers
          
        }
        else if (segue.identifier == "ReplySegue") {
            let indexPathRow = (sender as! UIButton).tag
            let tweet = tweets[indexPathRow];
            
            let composeVC = segue.destination as! ComposePageViewController
            composeVC.userReply = String("@\(tweet.pers.screenname)")
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
    

}
