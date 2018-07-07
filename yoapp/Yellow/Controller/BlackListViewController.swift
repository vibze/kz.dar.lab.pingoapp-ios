//
//  BlackListViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 22.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class BlackListViewController: UITableViewController {
    
    let titleHeaderView = BlockUserLabelView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
    var userBlockCell = "userBlockCell"
    var blackListArray = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        fetchBlaclList()
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
    
    func fetchBlaclList(){
        BlackListModel.fetchBlackListContactFromCore(completionHandler: {(array) in
            self.blackListArray = array
        })
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
        return blackListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userBlockCell, for: indexPath) as! BlockUserCell
        let name = blackListArray[indexPath.row].name
        let phoneNumber = blackListArray[indexPath.row].phoneNumber
        let image = blackListArray[indexPath.row].avatarUrl
        cell.viewData(image: image ?? "", name: name!, phone: phoneNumber!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = blackListArray[indexPath.row]
        showBlockUser(for: contact)
    }
   
    
    func showBlockUser(for contact: Contact){
        let vc = MessageViewController()
        vc.contact = contact
        openViewController(viewController: vc)
    }
}
