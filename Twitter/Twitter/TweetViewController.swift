//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sammy Torres II on 10/5/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // This displays a keyboard and cursor
        tweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    // Cancel Tweet
    @IBAction func cancel(_ sender: Any) {
        // When the user presses 'cancel'
        dismiss(animated: true, completion: nil)
    }
    
    // Post Tweet
    @IBAction func tweet(_ sender: Any) {
        
        if(!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { Error in
                print("Error posting tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else {
            self.dismiss(animated: true,completion: nil)
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
