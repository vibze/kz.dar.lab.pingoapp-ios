//
//  FavouriteWordViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 25.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class FavouriteWordViewController: UITableViewController {
    
    let headerView = SettingHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 80))
    var favourCell = "FavouriteCell"
    
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
        headerView.titleName(title: "Избранные фразы")
        tableView.tableHeaderView = headerView
        headerView.backButton.addTarget(self, action: #selector(bactToVC), for: .touchUpInside)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: favourCell)
    }
}

extension FavouriteWordViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favourCell, for: indexPath) as UITableViewCell
        cell.backgroundColor = .myYellow
        cell.textLabel?.text = "Привет! Как дела?"
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return cell
    }
    
}
