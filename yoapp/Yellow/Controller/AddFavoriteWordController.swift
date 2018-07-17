//
//  AddFavoriteWordController.swift
//  yoapp
//
//  Created by Kamila Kusainova on 11.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AddFavoriteWordController: UIViewController {
    var counter: Int = 0
    let addWordView = FavouriteAddView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addWordView)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.55)
        viewSetUp()
    }
    
    func viewSetUp() {
        addWordView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(30)
            $0.right.equalTo(-30)
            $0.height.equalTo(177)
        }
        addWordView.inputWord.text = ""
        addWordView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        addWordView.addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 100
        }
    }
    
    @objc func cancelAction() {
        dismiss(animated: false, completion: nil)
    }
    
    private func isTextContainsCharacter(_ word: String) -> Bool {
        for char in word.lowercased() {
            if SearchContact.checkCharacter(char) {
                return true
            }
        }
        return false
    }
    
    @objc func addAction() {
        guard let word = addWordView.inputWord.text, isTextContainsCharacter(word) else {
            showAlert(errorType: "Добавьте фразу", image: #imageLiteral(resourceName: "errorIcon"))
            return
        }
        FavoriteWordsServices.addFavoriteWordToCore(index: counter, word: word)
        dismiss(animated: false, completion: nil)
    }
}
