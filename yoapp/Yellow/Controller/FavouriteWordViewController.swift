//
//  FavouriteWordViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 25.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

class FavouriteWordViewController: UITableViewController {
    
    var favoriteCell = "FavouriteCell"
    let monitor = Monitor.favoriteWordsMonitor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationController(backgrounColor: .backgroundYellow, title: "Избранные фразы")
        addRightBtutton(action: #selector(addFavourWordAction))
        configTableView()
        monitor.addObserver(self)
    }
    
    func configTableView() {
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(SettingViewCell.self, forCellReuseIdentifier: favoriteCell)
    }
}

extension FavouriteWordViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monitor.numberOfObjects()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCell, for: indexPath) as! SettingViewCell
        guard (monitor[indexPath.row].word != nil) else {
            return cell
        }
        cell.textName(text: monitor[indexPath.row].word!)
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
            FavoriteWordsServices.deleteFavoriteWordFromCore(word: monitor[indexPath.row])
        }
    }
}

extension FavouriteWordViewController {
    @objc func addFavourWordAction() {
        let vc = AddFavoriteWordController()
        vc.counter = monitor.numberOfObjects()
        self.present(vc, animated: false, completion: nil)
    }
}

extension FavouriteWordViewController: ListObserver {
    func listMonitorDidChange(_ monitor: ListMonitor<FavoriteWords>) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<FavoriteWords>) { }
}
