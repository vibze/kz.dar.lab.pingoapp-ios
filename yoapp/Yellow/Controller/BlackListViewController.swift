//
//  BlackListViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

class BlackListViewController: UITableViewController {
    
    let titleHeaderView = BlockUserLabelView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
    var userBlockCell = "userBlockCell"
    let blackListMonitor = Monitor.blackListMonitor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        blackListMonitor.addObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationController(backgrounColor: .backgroundYellow, title: "Черный список")
    }
    
    func configTableView(){
        self.tableView = UITableView(frame: self.tableView.frame, style: .plain)
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
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
        return blackListMonitor.numberOfObjects()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userBlockCell, for: indexPath) as! BlockUserCell
        let name = blackListMonitor[indexPath.row].name
        let phoneNumber = blackListMonitor[indexPath.row].phoneNumber
        let image = blackListMonitor[indexPath.row].avatarUrl
        cell.viewData(image: image ?? "", name: name!, phone: phoneNumber!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = blackListMonitor[indexPath.row]
        showBlockUser(for: contact)
    }
    
    func showBlockUser(for contact: Contact){
        let vc = MessageViewController()
        vc.contact = contact
        openViewController(viewController: vc)
    }
}

extension BlackListViewController: ListObserver {
    func listMonitorDidChange(_ monitor: ListMonitor<Contact>) {
        self.tableView.reloadData()
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<Contact>) {
        
    }
}
