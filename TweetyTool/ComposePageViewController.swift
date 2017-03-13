//
//  ComposePageViewController.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 3/5/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class ComposePageViewController: UIViewController,  UITextViewDelegate  {
    
    @IBOutlet weak var tweetText: UITextView!
  
    //@IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var characterCountLabel: UILabel!
    
    //var tweet: Tweet!
    //var profileURL: URL!
    //var charCountLabel: UILabel!;
    var tweetButton: UIButton!;
    var userReply: String!
    //@IBOutlet weak var handleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.becomeFirstResponder()
        if userReply != nil {
            tweetText.text = "\(userReply) "
        }

        self.myImageView.setImageWith((User.currentUser?.userImageURL)!)

 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textViewDidChange(_ textView: UITextView) {
        
        if (tweetText.text?.characters.count)! < 0
        {
            characterCountLabel.textColor = UIColor.red
            characterCountLabel.text = "\(140 - (tweetText.text?.characters.count)!)"
            
        }
        else
        {
            characterCountLabel.text = "\(140 - (tweetText.text?.characters.count)!)"
        }

    }
    
    
    func textFieldDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder();
    }
    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil);
        
    }
    @IBAction func onTweetButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.postTweet(success: { () in
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
            }, failure: { (error: Error) in
                print("error: \(error.localizedDescription)")
            }, status: tweetText.text!)

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
