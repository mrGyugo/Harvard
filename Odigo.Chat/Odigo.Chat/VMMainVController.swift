//
//  VMMainVController.swift
//  Odigo.Chat
//
//  Created by Mac_Work on 15.05.17.
//  Copyright © 2017 ZebkaLab. All rights reserved.
//

import UIKit
import CoreData
import SwiftDDP
import CoreLocation

class VMMainVController:    VMMainViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var arrayCell = [UITableViewCell]()
    var accountData: AccountData?
    let locationManager = CLLocationManager()
    var searchCordinate: CLLocationCoordinate2D!
    
    
    private var statistics: [Statistic] = [] {
        didSet {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.keyboardDismissMode = .interactive
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
        searchCordinate = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }

    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCell.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return arrayCell[indexPath.row]
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    //MARK: - InputLoginViewCellDelegate
    func showKeyboard(inputCell: InputLoginViewCell) {
        UIView.animate(withDuration: 0.35, animations: {
            self.tableView.contentOffset = CGPoint(x: 0, y: 50)})
    }
    
    func hideKeyboard(inputCell: InputLoginViewCell) {
        UIView.animate(withDuration: 0.35, animations: {
            self.tableView.contentOffset = CGPoint(x: 0, y: 0)})
    }

}










