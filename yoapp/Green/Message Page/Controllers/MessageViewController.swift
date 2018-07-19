//
//  MessageViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import CoreStore

private struct Constants {
    static let messageCell = "messageCell"
    static let writeToContact = "Написать сообщение"
    static let blockContact = "Заблокировать контакт"
    static let unblockContact = "Разблокировать контакт"
    static let basePhrasesHeader = "Выберите базовые фразы"
    static let writeToFriendHeader = "Или напишите собеседнику"
}

class MessageViewController: UIViewController {

    var collectionView: UICollectionView!
    
    let profileImageBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 110 / 2
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        return view
    }()
    
    let profileImageView = ImageView()
    let phrasesMonitor = Monitor.favoriteWordsMonitor
    
    let writeButton = ActionButton(title: Constants.writeToContact, type: .write)
    let blockButton = ActionButton(title: Constants.blockContact, type: .block)
    
    let userNameLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 20, fontType: .myRegular)
    let phoneNumberLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 16, fontType: .myRegular)
    let basePhrasesTitleLabel = UILabel.basic(textColor: #colorLiteral(red: 0.1882352941, green: 0.5294117647, blue: 0.3411764706, alpha: 1), fontSize: 16, fontType: .myRegular)
    let messageTitleLabel = UILabel.basic(textColor: #colorLiteral(red: 0.1882352941, green: 0.5294117647, blue: 0.3411764706, alpha: 1), fontSize: 16, fontType: .myRegular)
    
    var contact: Contact?
    
    @objc func blockBtnPressed() {
        guard let isBlacklisted = contact?.isBlacklisted,
            let profileId = contact?.profileId, var blockButtonTitle = blockButton.titleLabel?.text else { return }
        if isBlacklisted {
            BlacklistService().unblacklistContact(profileId: profileId, {
                print("success")
                blockButtonTitle = Constants.blockContact
                self.blockButton.setTitle(blockButtonTitle, for: .normal)
            }) { (error) in
                print("err")
            }
            return
        }
        BlacklistService().blacklistContact(profileId: profileId, {
            print("success")
            blockButtonTitle = Constants.unblockContact
            self.blockButton.setTitle(blockButtonTitle, for: .normal)
        }) { (error) in
            print("err")
        }
    }
    
    @objc func writeBtnPressed() {
        let vc = ComposeViewController()
        vc.contact = contact
        openViewController(viewController: vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationController(backgrounColor: #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1), title: "")
        view.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1)
        
        phrasesMonitor.addObserver(self)
        
        setupViews()
        setupButtons()
        setupLabels()
        fillContactInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupButtons() {
        let blockButtonTitle = contact!.isBlacklisted ? Constants.unblockContact : Constants.blockContact
        blockButton.setTitle(blockButtonTitle, for: .normal)
        
        writeButton.addTarget(self, action: #selector(writeBtnPressed), for: .touchUpInside)
        blockButton.addTarget(self, action: #selector(blockBtnPressed), for: .touchUpInside)
    }
    
    func setupLabels() {
        basePhrasesTitleLabel.text = Constants.basePhrasesHeader
        messageTitleLabel.text = Constants.writeToFriendHeader
    }
    
    func fillContactInfo() {
        if let contact = contact, let phoneNumber = contact.phoneNumber {
            if let avatarUrl = contact.avatarUrl {
                profileImageView.setContactImage(url: avatarUrl)
            }
            userNameLabel.text = contact.name
            phoneNumberLabel.text = "+" + phoneNumber
        }
    }
    
    func setupViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.messageCell)
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
        
        [profileImageView, blockButton, profileImageBackgroundView, userNameLabel, writeButton, phoneNumberLabel, basePhrasesTitleLabel, messageTitleLabel].forEach { newView in
            view.addSubview(newView)
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
            $0.height.equalTo(50)
            $0.top.equalTo(basePhrasesTitleLabel.snp.bottom).offset(14)
        }
        
        basePhrasesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(16)
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
            $0.top.equalTo(topLayoutGuide.snp.bottom).offset(10)
            $0.height.width.equalTo(110)
            $0.centerX.equalTo(self.view.center)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(profileImageBackgroundView.snp.top).offset(5)
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
        return phrasesMonitor.numberOfObjects()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.messageCell, for: indexPath) as! MessageCollectionViewCell
        cell.phrase = phrasesMonitor[indexPath.row].word
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let buddy = contact, let sendText = phrasesMonitor[indexPath.row].word, let phoneNumber = buddy.phoneNumber else { return }
        
        PingsApi().postPing(buddyId: buddy.profileId, pingText: sendText, success: { _ in
            let alertView = AlertViewController()
            alertView.configView(isError: false)
            alertView.delegate = self
            self.present(alertView, animated: false, completion: nil)
            Store.updateContactPingTime(phoneNumber: phoneNumber, date: Date())
        }, failure: { _ in
            print("error")
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let phrase = phrasesMonitor[indexPath.row].word else { return CGSize(width: 0, height: 0) }
        let width = phrase.size().width
        return CGSize(width: width * 1.44 + 60, height: 50)
    }
}

extension MessageViewController: ListObserver {
    func listMonitorDidChange(_ monitor: ListMonitor<FavoriteWords>) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func listMonitorDidRefetch(_ monitor: ListMonitor<FavoriteWords>) {
    }
}

extension MessageViewController: AlertViewDelegate {
    func closeView(popupVC: AlertViewController) {
        dismiss(animated: false, completion: nil)
    }
}

