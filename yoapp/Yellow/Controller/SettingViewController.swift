//
//  SettingViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {

    let headerView = SettingHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 80))
    let footerView = SettingsFooterView(frame: CGRect(x: 0, y: 250, width: screenWidth, height: 100))
    
    var settingCell = "settingCell"
    var settingType = ["Черный список","Избранные фразы"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = false
        configTableView()
    }

    func configTableView(){
        tableView.backgroundColor = UIColor(hexString: "FEC95F")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 50
        headerView.titleName(title: "Настройки")
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(SettingViewCell.self, forCellReuseIdentifier: settingCell)
        headerView.backButton.addTarget(self, action: #selector(bactToVC), for: .touchUpInside)
    }
}

extension SettingViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCell, for: indexPath) as! SettingViewCell
        cell.backgroundColor = .myYellow
        cell.textName(text: settingType[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            openViewController(viewController: BlackListViewController())
        case 1:
             openViewController(viewController: FavouriteWordViewController())
        default:
            break
        }
    }
    
}
