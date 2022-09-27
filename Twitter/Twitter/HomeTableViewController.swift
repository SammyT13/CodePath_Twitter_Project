//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Sammy Torres II on 9/23/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit
// This is linked to the 'Home' Screen and 'Logout' button
class HomeTableViewController: UITableViewController {
    // An empty array of dictionaries
    var tweetArray = [NSDictionary]()
    
    // Number of Tweets
    var numOfTweet: Int!
    
    // Refresh control to give user ability to refresh tweets
    let myRefreshControl = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //This will load the tweets being called
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        // telling the table which fresh control to use
        tableView.refreshControl = myRefreshControl

    }
    
    // Pulling (getting) our tweets (calls our API)
    @objc func loadTweets(){
        numOfTweet = 20
        
        // API Call
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        // setting our parameters (tweet count)
        let myParams = ["count": numOfTweet]
        
        //Call the API (we used 'getDictionariesRequest' because we're pulling multiple tweets) to load initial tweets
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            // This empties entire array prior to for loop executing
            self.tweetArray.removeAll()
            
            // Stores our tweets in our 'tweetArray' (container)
            for tweet in tweets {
                // Adding tweets
                self.tweetArray.append(tweet)
            }
            // Makes sure we repopulate our list anytime we make a call to the API (updates the table)
            self.tableView.reloadData()
            
            // Makes sure we stop the update after user refresh
            self.myRefreshControl.endRefreshing()
            
        }, failure: { Error in
            print("Could not retrieve tweets! Oh no!!")
        })
    }
    
    // Infinitely load tweets versus 20 tweets after opening app
    func loadMoreTweets() {
        // API Call
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        // continues to add 20 more tweets after calling more 'loadMoreTweets'
        numOfTweet = numOfTweet + 20
        
        // setting parameter with + 20 more tweets when function is called
        let myParams = ["count": numOfTweet]
        
        //Calling the API (we used 'getDictionariesRequest' because we're pulling multiple tweets) to load more tweets
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            // This empties entire array prior to for loop executing
            self.tweetArray.removeAll()
            
            // Stores our tweets in our 'tweetArray' (container)
            for tweet in tweets {
                // Adding tweets
                self.tweetArray.append(tweet)
            }
            // Makes sure we repopulate our list anytime we make a call to the API (updates the table)
            self.tableView.reloadData()
            
            
        }, failure: { Error in
            print("Could not retrieve tweets! Oh no!!")
        })
    }
    
    // Will call the 'loadMoreTweets()' function to load more tweets
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
        }
    }
    

    @IBAction func onLogout(_ sender: Any) {
        // this is the logout function already created
        TwitterAPICaller.client?.logout()
        // this dismisses the Home screen after clicking logout
        self.dismiss(animated: true, completion: nil)
        // This sets the user is logged out - sets it to false
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    // Displays the pulled tweets
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        // Extracts the user key first (remember it has multiple keys)
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        // Extracts it from the user key to the name key
        cell.userNameLabel.text = user["name"] as? String
        
        // "text" was obtained from Twitter API example (it's the key to retreive tweets)
        cell.tweetsContentsLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        // This will pull the user image using key "profile_image_url_https"
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        // Sets the image from the cell
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        
        return cell
    }
    
    // MARK: - Table view data source
    // This says how many sections we want
    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return 1
    }
    // This says how many rows per section we want
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return tweetArray.count
    }


}
