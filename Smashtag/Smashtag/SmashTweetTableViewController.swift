//
//  SmashTweetTableViewController.swift
//  Smashtag
//
//  Created by Mac_Work on 10.10.17.
//  Copyright © 2017 Mac_Work. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetTableViewController: TweetTableViewController {
    
    
    var container: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    

    override func insertTweets(_ newTweets: [Twitter.Tweet]) {
        super.insertTweets(newTweets)
        updateDatabase(with: newTweets)
    }

    private func updateDatabase(with tweets: [Twitter.Tweet]) {
        container?.performBackgroundTask{ (context) in
            for twitterInfo in tweets {
                _ = try? Tweet.findOrCreateTweet(matching: twitterInfo, in: context)
            }
        }
        printDatabaseStatistics()
    }
    
    private func printDatabaseStatistics() {
        if let context = container?.viewContext {
            
        }
    }

}
