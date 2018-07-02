//
//  FavouriteWordViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 25.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

class FavouriteWordViewController: UIViewController, UITableViewDelegate,
                                   UITableViewDataSource {
    
    var favoriteCell = "FavouriteCell"
    var array = [FavoriteWordModel]()
    let backgroundView = UIView()
    let monitor = FavoriteWordModel.wordsMonitor
    
    var addWordView: FavouriteAddView = {
        let view = FavouriteAddView()
        return view
    }()
  
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.rowHeight = 50
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        addNavCon(backgrounColor: .backgroundYellow, title: "Избранные фразы")
        addRightBtutton(action: #selector(addFavourWordAction))
//        monitor.addObserver(self)
        configTableView()
        fetchFromCoreStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromCoreStore()
        self.tableView.reloadData()
    }
    /*
    func listMonitorDidChange(monitor: ListMonitor<FavoriteWords>) {
        tableView.reloadData()
    }
    
    func listMonitorDidRefetch(monitor: ListMonitor<FavoriteWords>) {
        tableView.reloadData()
    }*/
    
    func configTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingViewCell.self, forCellReuseIdentifier: favoriteCell)
        tableView.snp.makeConstraints{
            $0.top.left.right.bottom.equalToSuperview().offset(0)
        }
    }
}

extension FavouriteWordViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCell, for: indexPath) as! SettingViewCell
        cell.textName(text: array[indexPath.row].word!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.tableView.dataSource?.tableView!(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        return [deleteButton]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromCoreStore(word: (array[indexPath.row].word)!)
            array.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func addFavourWordAction(){
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(backgroundView)
        backgroundView.addSubview(addWordView)
        backgroundView.snp.makeConstraints{
            $0.top.left.right.bottom.equalToSuperview().offset(0)
        }
        
        addWordView.snp.makeConstraints{
            $0.top.equalTo(180)
            $0.left.equalTo(24)
            $0.right.equalTo(-24)
            $0.height.equalTo(220)
        }
        addWordView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        addWordView.addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
    }
    
    @objc func cancelAction(){
        addWordView.inputWord.text = " "
        addWordView.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
    
    @objc func addAction(){
        let word = addWordView.inputWord.text
        addToWord(index: 1, word: word!)
        addWordView.inputWord.text = " "
        tableView.reloadData()
        addWordView.removeFromSuperview()
        backgroundView.removeFromSuperview()
        tableView.reloadData()
    }
    
    func addToWord(index:Int,word:String){
        FavoriteWordModel.addToCore(index: index, word: word)
        fetchFromCoreStore()
    }
    
    func fetchFromCoreStore(){
        FavoriteWordModel.fetchFromCore(completionHandler: {(some) in
            self.array = some
        })
    }

    func deleteFromCoreStore(word: String){
         FavoriteWordModel.deleteFromCore(word: word)
    }
}

