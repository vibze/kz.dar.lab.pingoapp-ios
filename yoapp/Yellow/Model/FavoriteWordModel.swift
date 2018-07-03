//
//  FavoriteWordModel.swift
//  yoapp
//
//  Created by Kamila Kusainova on 28.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

class FavoriteWordModel {
    var index: Int?
    var word: String?
    
    init(index: Int,word:String){
        self.index = index
        self.word = word
    }
    
    static func addToCore(index: Int,word: String,completionHandler: @escaping([FavoriteWordModel]) -> ()){
        var array = [FavoriteWordModel]()
        var fetchArray = [FavoriteWordModel]()
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            guard transaction.fetchOne(From<FavoriteWords>().where(\.word == word)) == nil else {
                return
            }
            let addfavorWords = transaction.create(Into<FavoriteWords>())
            addfavorWords.word = word
            addfavorWords.index = Int16(index)
            let cat = FavoriteWordModel(index: index, word: word)
            array.append(cat)
            
            let fetching = transaction.fetchAll(From<FavoriteWords>().orderBy(.descending(\.index)))
            for index in fetching!{
                let types = FavoriteWordModel(index: Int(index.index), word: index.word!)
                fetchArray.append(types)
            }
            completionHandler(fetchArray)
        },completion: {(result) -> Void in
            debugPrint(result)
        })
    }
    
    static func fetchFromCore(completionHandler: @escaping([FavoriteWordModel]) -> ()){
        var array = [FavoriteWordModel]()
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            let fetching = transaction.fetchAll(From<FavoriteWords>().orderBy(.descending(\.index)))
            for index in fetching!{
                let cat = FavoriteWordModel(index: Int(index.index), word: index.word!)
                array.append(cat)
            }
            completionHandler(array)
        },completion: {(result) -> Void in
            debugPrint(result)
        })
    }
    
    static func deleteFromCore(word: String){
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            transaction.deleteAll(From<FavoriteWords>().where(\.word == word))
        },completion: {(result) -> Void in
            debugPrint(result)
        })
    }
}
