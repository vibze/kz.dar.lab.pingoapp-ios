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
    
    static func addToCore(index: Int,word: String){
        var array = [FavoriteWordModel]()
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            let person = transaction.create(Into<FavoriteWords>())
            person.word = word
            person.index = Int16(index)
            let cat = FavoriteWordModel(index: index, word: word)
            array.append(cat)
//            completionHandler(array)
        },completion: {(result) -> Void in
            debugPrint(result)
        })
    }
    
    static func fetchFromCore(completionHandler: @escaping([FavoriteWordModel]) -> ()){

        var array = [FavoriteWordModel]()
        CoreStore.perform(asynchronous: {(transaction) -> Void in
            let temp = transaction.fetchAll(From<FavoriteWords>().orderBy(.descending(\.index)))
            for index in temp!{
                let cat = FavoriteWordModel(index: Int(index.index), word: index.word!)
                array.append(cat)
                print(index.word!,index.index)
            }
            completionHandler(array)
        },completion: {(result) -> Void in
            debugPrint(result)
        })
    }
    
    
    static func deleteFromCore(index: Int){
    CoreStore.perform(asynchronous: {(transaction) -> Void in
//        transaction.deleteAll(From<FavoriteWords>().where(\.index == index))
//        guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue, transaction.fetchOne(From<Contact>().where(\.phoneNumber == phoneNumber)) == nil else {

      
    },completion: {(result) -> Void in
    debugPrint(result)
    })
    }
}
