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
    var favoriteWordArray = [FavoriteWords]()
    let backgroundView = UIView()
    
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
        addNavigationController(backgrounColor: .backgroundYellow, title: "Избранные фразы")
        addRightBtutton(action: #selector(addFavourWordAction))
        configTableView()
        fetchFromCoreStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFromCoreStore()
        self.tableView.reloadData()
    }
    
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
        return favoriteWordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCell, for: indexPath) as! SettingViewCell
        cell.textName(text: favoriteWordArray[indexPath.row].word!)
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
            print(favoriteWordArray[indexPath.row].index)
//            deleteFavoriteWordFromCore(word: (favoriteWordArray[indexPath.row].word)!)
            favoriteWordArray.remove(at: indexPath.row)
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
            $0.centerY.equalToSuperview()
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
            $0.height.equalTo(177)
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
        addToWord(index: favoriteWordArray.count + 1, word: word!)
        addWordView.inputWord.text = " "
        addWordView.removeFromSuperview()
        backgroundView.removeFromSuperview()
        tableView.reloadData()
    }
    
    func addToWord(index:Int,word:String){
        FavoriteWordModel.addFavoriteWordToCore(index: index, word: word){(array) in
            self.favoriteWordArray = array
        }
    }
    
    func fetchFromCoreStore(){
        FavoriteWordModel.fetchFavoriteWordFromCore(completionHandler: {(array) in
            self.favoriteWordArray = array
        })
    }

    func deleteFavoriteWordFromCore(word: String){
         FavoriteWordModel.deleteFavoriteWordFromCore(word: word)
    }
}
