//
//  TweetCell.swift
//  Twitter
//
//  Created by Mathew Chanda on 10/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    var favorited : Bool = false;
    var tweetID : Int =  -1;

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweet(_ sender: Any) {
        print(tweetID)
        TwitterAPICaller.client?.retweet(tweetId: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error is retweeting: \(Error)")
        })
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetID, success: {
                self.setFavorited(true)
            }, failure: { (Error) in
                print("Favoited did not succeed: \(Error)")
            })
        }
        
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetID, success: {
                self.setFavorited(false)
            }, failure: { (Error) in
                print("Unfavoited did not succeed: \(Error)")
            })
        }
    }
    
    func setFavorited(_ isFavorited : Bool){
        favorited = isFavorited
        if(favorited == true ){
            favButton.setImage(UIImage(named : "favor-icon-red"), for: UIControl.State.normal)
        }
        
        
        else{
            favButton.setImage(UIImage(named :"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted : Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        
       else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
}
