//
//  FavouriteWordViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 25.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

class FavouriteWordViewController: UITableViewController, ListObserver {
    
    var favoriteCell = "FavouriteCell"
    var favoriteWordArray = [FavoriteWords]()
    let monitor = Monitor.favoriteWordsMonitor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationController(backgrounColor: .backgroundYellow, title: "Избранные фразы")
        addRightBtutton(action: #selector(addFavourWordAction))
        configTableView()
        monitor.addObserver(self)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromCoreStore()
        self.tableView.reloadData()
    }
    
    func configTableView(){
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(SettingViewCell.self, forCellReuseIdentifier: favoriteCell)
    }
}

extension FavouriteWordViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteWordArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCell, for: indexPath) as! SettingViewCell
        guard (favoriteWordArray[indexPath.row].word != nil) else{
            return cell
        }
        cell.textName(text: favoriteWordArray[indexPath.row].word!)
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
            deleteFavoriteWordFromCore(word: (favoriteWordArray[indexPath.row]))
            favoriteWordArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension FavouriteWordViewController {
    
    @objc func addFavourWordAction(){
        let vc = AddFavoriteWordController()
        vc.favoriteWordArray = favoriteWordArray
        self.present(vc, animated: false, completion: nil)
    }
    
    @objc func fetchFromCoreStore(){
        FavoriteWordsServices.fetchFavoriteWordFromCore(completionHandler: {(array) in
            self.favoriteWordArray = array
        })
    }
    
    func deleteFavoriteWordFromCore(word: FavoriteWords){
        FavoriteWordsServices.deleteFavoriteWordFromCore(word: word)
    }
    
    func listMonitorDidChange(_ monitor: ListMonitor<FavoriteWords>) {
        favoriteWordArray = monitor.objectsInAllSections()
        self.tableView.reloadData()
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<FavoriteWords>) {
        self.tableView.reloadData()
    }
}
