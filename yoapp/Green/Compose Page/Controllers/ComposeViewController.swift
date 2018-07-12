//
//  ComposeViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import UserNotifications

class ComposeViewController: UIViewController {
    
    let phoneNumberLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 16, fontType: .myRegular)
    let nameLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 20, fontType: .myRegular)
    let composeButton = ActionButton(title: "Отправить сообщение", type: .write)
    let profileImageView = ImageView(radius: 90 / 2)
    let alertView = PushAlert()
    let messageTextView = MessageTextView()

    var contact: Contact?
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func composeButtonPressed() {
        guard let buddy = contact
            ,let sendText = messageTextView.text
            ,let phoneNumber = buddy.phoneNumber else { return }

        PingsApi().postPing(buddyId: buddy.profileId, pingText: sendText, success: { _ in
                self.alertView.isHidden = false
                self.navigationController?.isNavigationBarHidden = true
                Store.updateContactPingTime(phoneNumber: phoneNumber)
            }, failure: { _ in
                self.showAlert(errorType: "Ошибка! Сообщение не доставлено.", image: #imageLiteral(resourceName: "errorIcon"))
        })
        print("tap&send")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fillContactInfo()
        composeButton.addTarget(self, action: #selector(composeButtonPressed), for: .touchUpInside)
        addNavigationController(backgrounColor: #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1), title: "")
        messageTextView.delegate = self
        alertView.delegate = self
        view.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1)
    }
    
    func fillContactInfo() {
        if let contact = contact {
            nameLabel.text = contact.name
            phoneNumberLabel.text = contact.phoneNumber
            guard let avatarUrl = contact.avatarUrl else { return }
            profileImageView.setContactImage(url: avatarUrl)
        }
    }
    
    func setupViews() {
        [profileImageView, phoneNumberLabel, nameLabel, composeButton, messageTextView, alertView].forEach {
            view.addSubview($0)
        }
        alertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.centerX.equalTo(self.view.center)
            $0.width.height.equalTo(90)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.centerX.equalTo(self.view.center)
        }
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(self.view.center)
        }
        messageTextView.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(100)
        }
        composeButton.snp.makeConstraints {
            $0.top.equalTo(messageTextView.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }
    }
}

extension ComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.hideKeyboard()
    }
}

extension ComposeViewController: AlerViewDelegate {
    func closeButtonTapped(isClosed: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}


