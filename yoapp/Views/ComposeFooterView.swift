//
//  ComposeFooterView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 16.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ComposeFooterView: UIView, UITextViewDelegate {
    
    var messageText: UITextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.isUserInteractionEnabled = true
        textView.layer.borderColor = #colorLiteral(red: 0.3529411765, green: 0.6274509804, blue: 0.4745098039, alpha: 1).cgColor
        textView.layer.borderWidth = 5
        textView.font = UIFont(name: "Avenir Next", size: 18)
        textView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textView.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        textView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 10)
        return textView
    }()
    
    let composeButton = ActionButton(title: "Отправить сообщение", type: .write)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(messageText)
        self.addSubview(composeButton)
        configView()
    }
    
    func configView(){
        composeButton.isUserInteractionEnabled = true
        messageText.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(100)
        }
        
        composeButton.snp.makeConstraints {
            $0.top.equalTo(messageText.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(50)
            $0.bottom.equalTo(self)
        }
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.hideKeyboard))
        
        toolBar.setItems([flexible, doneBTN], animated: false)
        messageText.inputAccessoryView = toolBar
    }
    
    @objc func hideKeyboard(){
        self.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
