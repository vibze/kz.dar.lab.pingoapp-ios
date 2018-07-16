//
//  BlackListViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

class BlackListViewController: UITableViewController, ListObserver {
    
    let titleHeaderView = BlockUserLabelView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
    let footerView = BlackListFooterView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
    var userBlockCell = "userBlockCell"
    let blackListMonitor = Monitor.blackListMonitor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        blackListMonitor.addObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        addNavigationController(backgrounColor: .backgroundYellow, title: "Черный список")
    }
    
    func configTableView(){
        self.tableView = UITableView(frame: self.tableView.frame, style: .plain)
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.tableFooterView = footerView
        tableView.rowHeight = 75
        tableView.register(BlockUserCell.self, forCellReuseIdentifier: userBlockCell)
    }
}

extension BlackListViewController {
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = titleHeaderView
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let blackListCount = blackListMonitor.numberOfObjects()
        if blackListCount == 0 {
            tableView.tableFooterView?.isHidden = false
        }else{
            tableView.tableFooterView?.isHidden = true
        }
        return blackListCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userBlockCell, for: indexPath) as! BlockUserCell
        let name = blackListMonitor[indexPath.row].name
        let phoneNumber = blackListMonitor[indexPath.row].phoneNumber
        let image = blackListMonitor[indexPath.row].avatarUrl
        cell.viewData(image: image ?? "", name: name!, phone: phoneNumber!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        return [deleteButton]
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contactId = blackListMonitor[indexPath.row].profileId
            BlacklistService().unblacklistContact(profileId: contactId, {
                print("success")
            }) { (error) in
                print("error")
            }
          
        }
    }
    
    func listMonitorDidChange(_ monitor: ListMonitor<Contact>) {
        self.tableView.reloadData()
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<Contact>) {
    }
}

