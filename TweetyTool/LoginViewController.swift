//
//  LoginViewController.swift
//  TweetyTool
//
//  Created by Vaidehi Duraphe on 2/20/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.login(success: {
            print("I've logged in!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }, failure: { (error: Error) in
                print(error.localizedDescription)
        })
        
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
