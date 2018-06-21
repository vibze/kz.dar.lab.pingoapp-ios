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
}

class MessageViewController: UIViewController {

    let defaultMessages = ["Привет", "Как дела?", "Что делаешь?", "Привет", "Как дела?", "Что делаешь?"]
    var contact: String?
    var collectionView: UICollectionView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let profileImageBackgroundView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 110 / 2
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        return view
    }()
    
    let profileImageView = ImageView(radius: 100 / 2)
    
    let backButton: UIButton = {
        let backBtn = UIButton()
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        backBtn.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        return backBtn
    }()
    
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
        label.textColor = UIColor(hexString: "308757")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "6BBE90")
        setupViews()
        setupButtons()
    }
    
    func setupButtons() {
        writeButton.addTarget(self, action: #selector(writeBtnPressed), for: .touchUpInside)
        blockButton.addTarget(self, action: #selector(blockBtnPressed), for: .touchUpInside)
    }
    
    @objc func writeBtnPressed() {
    }
    
    @objc func blockBtnPressed() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let contact = contact {
            userNameLabel.text = contact
        }
    }
    
    @objc func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        [backButton, profileImageView, blockButton, profileImageBackgroundView, userNameLabel, writeButton, phoneNumberLabel, basePhrasesTitleLabel, messageTitleLabel].forEach { newView in
            view.addSubview(newView)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: 50)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.messageCell)
        
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
    
        blockButton.snp.makeConstraints {
            $0.top.equalTo(writeButton.snp.bottom).offset(16)
            $0.left.equalTo(32)
            $0.width.equalTo(self.view.frame.width - 2 * 32)
            $0.height.equalTo(50)
        }
        
        messageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(24)
            $0.left.equalTo(32)
        }
    
        collectionView.snp.makeConstraints {
            $0.left.equalTo(32)
            $0.width.equalTo(self.view.frame.width - 2 * 32)
            $0.height.equalTo(120)
            $0.top.equalTo(basePhrasesTitleLabel.snp.bottom).offset(14)
        }
        
        basePhrasesTitleLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(22)
            $0.left.equalTo(32)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(1)
            $0.centerX.equalTo(self.view.center)
        }
        writeButton.snp.makeConstraints {
            $0.top.equalTo(messageTitleLabel.snp.bottom).offset(22)
            $0.left.equalTo(32)
            $0.width.equalTo(self.view.frame.width - 2 * 32)
            $0.height.equalTo(50)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.centerX.equalTo(self.view.center)
        }
        profileImageBackgroundView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(5)
            $0.height.width.equalTo(110)
            $0.centerX.equalTo(self.view.center)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(10)
            $0.height.width.equalTo(100)
            $0.centerX.equalTo(self.view.center)
        }
        backButton.snp.makeConstraints {
            $0.left.top.equalTo(32)
            $0.width.height.equalTo(24)
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = defaultMessages[indexPath.row].count;
        return CGSize(width: width * 5 + 60, height: 50)
    }
}
