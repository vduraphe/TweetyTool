//
//  ComposePageViewController.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 3/5/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class ComposePageViewController: UIViewController,  UITextViewDelegate  {
    
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    var tweet: Tweet!
    //var profileURL: URL!
    var charCountLabel: UILabel!;
    var tweetButton: UIButton!;
    
    var replyToTweet: Tweet?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        myImageView.setImageWith((tweet!.pers.profileUrl!))
        nameLabel.text = tweet!.pers.name
        handleLabel.text = "@\(tweet!.pers.screenname!)"
 */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "What's happening?") {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        if(textView.text == "") {
            textView.text = "What's happening?";
            textView.textColor = UIColor.gray
        }
        textView.resignFirstResponder();
    }
    @IBAction func onTweetButton(_ sender: AnyObject) {
        let composedText = textLabel.text;
        var sendToId = 0
        TwitterClient.sharedInstance?.publishTweet(text: composedText!, replyToTweetID: sendToId) { (newTweet: Tweet) -> () in
            
        }
        dismiss(animated: true, completion: nil);
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
