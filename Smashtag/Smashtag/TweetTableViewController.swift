//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Mac_Work on 06.10.17.
//  Copyright © 2017 Mac_Work. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController {
    
    private var tweets = [Array<Tweet>]()
    
    var searchText: String?
    {
        didSet {
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        
        }
    }
    
    private func searchForTweets() {
        
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

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
