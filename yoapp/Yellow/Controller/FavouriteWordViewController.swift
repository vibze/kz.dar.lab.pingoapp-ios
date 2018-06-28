//
//  FavouriteWordViewController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 25.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreData

class FavouriteWordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var favoriteCell = "FavouriteCell"
    var array: [NSManagedObject] = []
   
    let backgroundView = UIView()
    
    var addWordView: FavouriteAddView = {
        let view = FavouriteAddView()
        return view
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.rowHeight = 50
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        addNavCon(backgrounColor: .backgroundYellow, title: "Избранные фразы")
        addRightBtutton(action: #selector(addFavourWordAction))
        configTableView()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 10.0, *) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteWords")
            do{
                array = try managedContext.fetch(fetchRequest)
            }catch let error as NSError{
                print(error)
            }
            tableView.reloadData()
        }else{
            print("Nothing")
        }
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
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCell, for: indexPath) as! SettingViewCell
        let data = array[indexPath.row]
        cell.textName(text: (data.value(forKey: "word") as? String)!)
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
             if #available(iOS 10.0, *) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(array[indexPath.row] as NSManagedObject)
            array.remove(at: indexPath.row)
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print(error.userInfo)
                }
            }
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
        save(favorWord: word!)
        addWordView.inputWord.text = " "
        tableView.reloadData()
        addWordView.removeFromSuperview()
        backgroundView.removeFromSuperview()
        tableView.reloadData()
    }
    
    func save(favorWord: String){
        if #available(iOS 10.0, *) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "FavoriteWords", in: managedContext)
            let item = NSManagedObject(entity: entity!, insertInto: managedContext)
            item.setValue(favorWord, forKey: "word")
            do{
                try managedContext.save()
                array.append(item)
            }catch let error as NSError{
                print(error)
            }
        }else{
            print("Nothing")
        }
    }
}
