//
//  FavoriteWordsServices.swift
//  yoapp
//
//  Created by Kamila Kusainova on 15.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

class FavoriteWordsServices {
    
    static func addFavoriteWordToCore(index: Int, word: String) {
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            if transaction.fetchOne(From<FavoriteWords>().where(\.word == word)) == nil{
                let favoriteWords = transaction.create(Into<FavoriteWords>())
                favoriteWords.word = word
                favoriteWords.index = Int16(index)
            }
        }, completion: {(result) -> Void in
            switch result {
            case .success:
                print("success")
            case .failure:
                print("failure")
            }
        })
    }
    
    static func deleteFavoriteWordFromCore(word: FavoriteWords) {
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            transaction.delete(word)
        }, completion: {(result) -> Void in
            switch result {
            case .success:
                print("success")
            case .failure:
                print("failure")
            }
        })
    }
}
