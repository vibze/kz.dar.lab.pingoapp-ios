//
//  BlackListViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class BlackListViewController: UITableViewController {
    
    let headerView = SettingHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 80))
    let titleHeaderView = BlockUserLabelView(frame: CGRect(x: 0, y: 60, width: screenWidth, height: 100))
    var userBlockCell = "userBlockCell"

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.isNavigationBarHidden = false
        configTableView()
    }
    
    func configTableView(){
        self.tableView = UITableView(frame: self.tableView.frame, style: .plain)
        tableView.backgroundColor = UIColor(hexString: "FEC95F")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 75
//        tableView.isScrollEnabled = false
        headerView.titleName(title: "Черный список")
        tableView.tableHeaderView = headerView
        headerView.backButton.addTarget(self, action: #selector(bactToVC), for: .touchUpInside)
        tableView.register(BlockUserCell.self, forCellReuseIdentifier: userBlockCell)
    }
}

extension BlackListViewController {
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = titleHeaderView
        return view
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userBlockCell, for: indexPath) as! BlockUserCell
        cell.data(image: #imageLiteral(resourceName: "cameraPhoto"), name: "Kamila", phone: "+77014849741")
//        cell.accessibilityScroll(.down)
        return cell
    }
    
}
