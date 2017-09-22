//
//  VMFriendsViewController.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 15.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import SwiftDDP
import CoreData

class VMFriendsViewController: VMMainViewController, UITableViewDataSource, UITableViewDelegate, MeteorCollectionType {
    
     @IBOutlet weak var tableView: UITableView!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.delegate = self
        tableView.dataSource = self


    }

    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }
    
    deinit {
        print("By Friends")
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") as UITableViewCell
        }
        return cell!;
    }
    
    
    
    //MARK: - MeteorCollectionType
    
    func documentWasAdded(_ collection:String, id:String, fields:NSDictionary?) {
        
        
        print(collection)
        print(fields ?? "nil")
        
    }
    func documentWasChanged(_ collection:String, id:String, fields:NSDictionary?, cleared:[String]?) {
        
        print(collection)
        print(fields ?? "nil")
        
    }
    func documentWasRemoved(_ collection:String, id:String) {
        
        print(collection)
        print(id)
        
        
    }
    

    
}
