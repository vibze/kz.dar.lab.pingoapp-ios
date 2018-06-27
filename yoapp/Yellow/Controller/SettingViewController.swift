//
//  SettingViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    let footerView = SettingsFooterView(frame: CGRect(x: 0, y: 250, width: screenWidth, height: 100))
    
    var settingCell = "settingCell"
    var settingType = ["Черный список","Избранные фразы"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        CustomNavBarView.addNavCon(vc: self, backgrounColor: .backgroundYellow, title: "Настройки")
        configTableView()
    }
    
    func configTableView(){
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 50
        tableView.tableFooterView = footerView
        tableView.register(SettingViewCell.self, forCellReuseIdentifier: settingCell)
    }
}

extension SettingViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingType.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCell, for: indexPath) as! SettingViewCell
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
