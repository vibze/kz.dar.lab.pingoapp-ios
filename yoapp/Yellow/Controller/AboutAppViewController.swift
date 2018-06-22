//
//  AboutAppViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AboutAppViewController: UITableViewController {

      let headerView = SettingHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
    }

    func configTableView(){
        tableView.backgroundColor = UIColor(hexString: "FEC95F")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 50
         headerView.titleName(title: "О приложении")
        tableView.tableHeaderView = headerView
        headerView.backButton.addTarget(self, action: #selector(bactToVC), for: .touchUpInside)
    }
    
  
    
}
