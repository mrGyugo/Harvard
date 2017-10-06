//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Mac_Work on 06.10.17.
//  Copyright © 2017 Mac_Work. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController {
    
    private var tweets = [Array<Twitter.Tweet>]() {
        didSet{
            print (tweets)
        }
    }
    
    var searchText: String?
    {
        didSet {
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        
        }
    }
    
    private var lastTwitterRequest: Twitter.Request?
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            lastTwitterRequest = request
            request.fetchTweets({ [weak self] newTweets in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.tweets.insert(newTweets, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            })
        }
    }
    
    private func twitterRequest() -> Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchText = "#stanford"
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)

        let tweet: Tweet = tweets[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user.name

        return cell
    }
 

}
