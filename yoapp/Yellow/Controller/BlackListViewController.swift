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

    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavBarView.addNavCon(vc: self, backgrounColor: .backgroundYellow, title: "Черный список")
        configTableView()
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
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userBlockCell, for: indexPath) as! BlockUserCell
        cell.data(image: #imageLiteral(resourceName: "cameraPhoto"), name: "Kamila", phone: "+77014849741")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showBlockUser(user_id: "\(indexPath.row)")
    }
    
    func showBlockUser(user_id: String){
        let vc = MessageViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
