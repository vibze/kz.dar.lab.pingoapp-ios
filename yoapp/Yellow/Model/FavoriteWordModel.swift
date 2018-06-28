//
//  FavoriteWordModel.swift
//  yoapp
//
//  Created by Kamila Kusainova on 28.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreData

class FavoriteWordModel {
    var index: String?
    var word: String?
    
    init(index: String, word: String) {
        self.index = index
        self.word = word
    }
    /*
    static func dataFromCoreData(favorWord: String,completionHandler: @escaping ([FavoriteWordModel]) -> ()) {
        var allData = [FavoriteWordModel]()
        if #available(iOS 10.0, *) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "FavoriteWords", in: managedContext)
            let item = NSManagedObject(entity: entity!, insertInto: managedContext)
            item.setValue(favorWord, forKey: "word")
            
            do{
                try managedContext.save()
                let some = FavoriteWordModel(index: "", word: "")
                    allData.append(some)
            }catch let error as NSError{
                print(error)
            }
            
        }
    }
    */
}
