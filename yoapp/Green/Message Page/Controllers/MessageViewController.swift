//
//  MessageViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

private struct Constants {
    static let messageCell = "messageCell"
    static let blockContact = "Заблокировать контакт"
    static let unblockContact = "Разблокировать контакт"
}

class MessageViewController: UIViewController {

    let defaultMessages = ["Привет", "Как дела?", "Что делаешь?", "Привет", "Как дела?", "Что?", "Привет", "Как дела?", "Что делаешь?", "Привет", "Как дела?", "Что?"]
    var contact: Contact?
    var collectionView: UICollectionView!
    
    let profileImageBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 110 / 2
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        return view
    }()
    
    let profileImageView = ImageView(radius: 100 / 2)
    let pushAlert = PushAlert()
    
    let userNameLabel: UILabel = {
        let username = UILabel()
        username.textAlignment = .center
        username.font = UIFont(name: "Avenir Next", size: 20)
        username.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        return username
    }()
    
    let phoneNumberLabel: UILabel = {
        let phoneNum = UILabel()
        phoneNum.textAlignment = .center
        phoneNum.font = UIFont(name: "Avenir Next", size: 16)
        phoneNum.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return phoneNum
    }()

    let writeButton = ActionButton(title: "Написать сообщение", type: .write)
    let blockButton = ActionButton(title: "Заблокировать контакт", type: .block)
    
    let basePhrasesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите базовые фразы"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = UIColor(hexString: "308757")
        return label
    }()

    let messageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Или напишите собеседнику"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = #colorLiteral(red: 0.1882352941, green: 0.5294117647, blue: 0.3411764706, alpha: 1)
        return label
    }()
    
    @objc func blockBtnPressed() {
        guard let isBlacklisted = contact?.isBlacklisted else { return }
        Message().performBlock(profileId: contact!.profileId, isBlacklisted: isBlacklisted) { (message) in
            if let message = message {
                print(message)
            }
            else {
                let blockButtonTitle = isBlacklisted ? Constants.blockContact : Constants.unblockContact
                self.blockButton.setTitle(blockButtonTitle, for: .normal)
            }
        }
    }
    
    @objc func writeBtnPressed() {
        let vc = ComposeViewController()
        openViewController(viewController: vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavCon(backgrounColor: #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1), title: "")
        view.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1)
        setupViews()
        setupButtons()
        
        if let contact = contact {
            userNameLabel.text = contact.name
            phoneNumberLabel.text = contact.phoneNumber
        }
    }
    
    func setupButtons() {
        let blockButtonTitle = contact!.isBlacklisted ? Constants.unblockContact : Constants.blockContact
        blockButton.setTitle(blockButtonTitle, for: .normal)
        
        writeButton.addTarget(self, action: #selector(writeBtnPressed), for: .touchUpInside)
        blockButton.addTarget(self, action: #selector(blockBtnPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.messageCell)
        
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
        
        [profileImageView, blockButton, profileImageBackgroundView, userNameLabel, writeButton, phoneNumberLabel, basePhrasesTitleLabel, messageTitleLabel, pushAlert].forEach { newView in
            view.addSubview(newView)
        }
        
        pushAlert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        blockButton.snp.makeConstraints {
            $0.top.equalTo(writeButton.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }
        
        messageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(32)
        }
        
        collectionView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(120)
            $0.top.equalTo(basePhrasesTitleLabel.snp.bottom).offset(14)
        }
        
        basePhrasesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(22)
            $0.left.equalToSuperview().offset(32)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(1)
            $0.centerX.equalTo(self.view.center)
        }
        writeButton.snp.makeConstraints {
            $0.top.equalTo(messageTitleLabel.snp.bottom).offset(22)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(self.view.center)
        }
        profileImageBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.height.width.equalTo(110)
            $0.centerX.equalTo(self.view.center)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.height.width.equalTo(100)
            $0.centerX.equalTo(self.view.center)
        }
    }
}

extension MessageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultMessages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.messageCell, for: indexPath) as! MessageCollectionViewCell
        
        cell.textLabel.text = defaultMessages[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushAlert.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = defaultMessages[indexPath.row].size().width
        return CGSize(width: width + 60, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
