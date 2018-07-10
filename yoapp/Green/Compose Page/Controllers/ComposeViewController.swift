//
//  ComposeViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    let profileImageView = ImageView(radius: 90 / 2)
    let composeButton = ActionButton(title: "Отправить сообщение", type: .write)
    let alertView = PushAlert()
    var contact: Contact?

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Avenir Next", size: 20)
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont(name: "Avenir Next", size: 16)
        return label
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.isUserInteractionEnabled = true
        textView.layer.borderColor = UIColor(hexString: "5AA079").cgColor
        textView.layer.borderWidth = 5
        textView.font = UIFont(name: "Avenir Next", size: 18)
        textView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textView.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
        return textView
    }()
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func composeButtonPressed() {
       
        let txt = messageTextView.text
        let buddyId = contact?.profileId
        PingsApi().postPing(buddyId: buddyId!, pingText: txt!, success: { _ in
            self.alertView.isHidden = false}, failure: { _ in
            self.showAlert(errorType: "Ошибка! Сообщение не доставлено.", image: #imageLiteral(resourceName: "errorIcon")) })
        
        print("tap&send")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fillContactInfo()
        addNavigationController(backgrounColor: #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1), title: "")
        messageTextView.delegate = self
        composeButton.addTarget(self, action: #selector(composeButtonPressed), for: .touchUpInside)
        alertView.delegate = self
        view.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1)
    }
    
    func fillContactInfo() {
        if let contact = contact {
            if let avatarUrl = contact.avatarUrl {
                profileImageView.setContactImage(url: avatarUrl)
            }
            nameLabel.text = contact.name
            phoneNumberLabel.text = contact.phoneNumber
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


