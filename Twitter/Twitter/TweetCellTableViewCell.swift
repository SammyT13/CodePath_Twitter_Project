//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Sammy Torres II on 9/27/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetsContentsLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    // action func for when the user presses favorite or unfavorite
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTwee(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { Error in
                print("Favorite did not succeed: \(Error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTwee(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { Error in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { Error in
            print("Error is retweeting: \(Error)")
        })
    }
    
    // determines if it's been retweeted
    func setRetweeted(_ isRetweeted: Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false // make it that nothing happens
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true // make it change
        }
    }
    
    // Boolean Twitter objects
    var favorited:Bool = false
    var tweetID: Int = -1
    
    // this is when we set something to favorite
    func setFavorite(_ isFavorited: Bool) {
        favorited = isFavorited
        
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
