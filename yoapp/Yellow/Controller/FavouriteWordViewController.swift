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
    var array = ["Привет, как дела?","Привет","Что делаешь?","Привет, как дела?","Привет","Что делаешь?"]
    
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
        tableView.register(SettingViewCell.self, forCellReuseIdentifier: favourCell)
    }
}

extension FavouriteWordViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favourCell, for: indexPath) as! SettingViewCell
//        cell.backgroundColor = .myYellow
//        cell.textLabel?.text = array[indexPath.row]
//        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.textName(text: array[indexPath.row])
        
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
            self.array.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
