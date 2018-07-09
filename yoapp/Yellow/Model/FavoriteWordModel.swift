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
    
    static func addFavoriteWordToCore(index: Int,word: String,completionHandler: @escaping([FavoriteWords]) -> ()){
       CoreStore.perform(asynchronous: {(transaction) -> Void in
        if transaction.fetchOne(From<FavoriteWords>().where(\.word == word)) != nil{
            transaction.deleteAll(From<FavoriteWords>().where(\.word == word))
        }
        
            let addfavorWords = transaction.create(Into<FavoriteWords>())
            addfavorWords.word = word
            addfavorWords.index = Int16(index)
            
            let fetching = transaction.fetchAll(From<FavoriteWords>().orderBy(.descending(\.index)))
            completionHandler(fetching!)
        },completion: {(result) -> Void in
        })
    }
    
    static func fetchFavoriteWordFromCore(completionHandler: @escaping([FavoriteWords]) -> ()){
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            let allFavoriteWords = transaction.fetchAll(From<FavoriteWords>()
                                      .orderBy(.descending(\.index)))
            completionHandler(allFavoriteWords!)
        },completion: {(result) -> Void in
        })
    }
    
    static func deleteFavoriteWordFromCore(word: FavoriteWords){
        CoreStore.perform(asynchronous: {(transaction) -> Void in
//            transaction.deleteAll(From<FavoriteWords>().where(\.word == word))
            transaction.delete(word)
        },completion: {(result) -> Void in
            debugPrint(result)
        })
    }
}
