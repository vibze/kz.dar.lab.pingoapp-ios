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

    let defaultMessages = ["Привет", "Как дела?", "Что делаешь?"]
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
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100 / 2
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.init(hexString: "E36C82").cgColor
        imageView.image = #imageLiteral(resourceName: "contactPlaceholder")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let backButton: UIButton = {
        let backBtn = UIButton()
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        backBtn.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        return backBtn
    }()
    
    let userName: UILabel = {
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
    
    let writeButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexString: "FFC65B")
        btn.addTarget(self, action: #selector(writeBtnPressed), for: .touchUpInside)
        btn.setTitleColor(UIColor(hexString: "308757"), for: .normal)
        btn.setTitle("Написать сообщение", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor(hexString: "308757").cgColor
        btn.layer.borderWidth = 5
        btn.setTitleColor(UIColor.init(hexString: "9C4272"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)
        return btn
    }()
    
    let blockButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
        btn.setTitleColor(UIColor(hexString: "AA4778"), for: .normal)
        btn.addTarget(self, action: #selector(blockBtnPressed), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor(hexString: "AA4778").cgColor
        btn.layer.borderWidth = 5
        btn.setTitle("Заблокировать контакт", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir Next", size: 18)
        return btn
    }()
    
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
    
    @objc func writeBtnPressed() {
    }
    
    @objc func blockBtnPressed() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "6BBE90")
            
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let contact = contact {
            userName.text = contact
        }
    }
    
    @objc func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        [backButton, profileImageView, blockButton, profileImageBackgroundView, userName, writeButton, phoneNumberLabel, basePhrasesTitleLabel, messageTitleLabel].forEach { newView in
            view.addSubview(newView)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: 50)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.messageCell)

        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsSelection = true
        view.addSubview(collectionView)
    
        blockButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(writeButton.snp.bottom).offset(16)
            constraint.left.equalTo(32)
            constraint.width.equalTo(self.view.frame.width - 2 * 32)
            constraint.height.equalTo(50)
        }
        
        messageTitleLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(collectionView.snp.bottom).offset(24)
            constraint.left.equalTo(32)
        }
    
        collectionView.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(32)
            constraint.width.equalTo(self.view.frame.width - 2 * 32)
            constraint.height.equalTo(120)
            constraint.top.equalTo(basePhrasesTitleLabel.snp.bottom).offset(14)
        }
        
        basePhrasesTitleLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(phoneNumberLabel.snp.bottom).offset(22)
            constraint.left.equalTo(32)
        }
        
        phoneNumberLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(userName.snp.bottom).offset(1)
            constraint.centerX.equalTo(self.view.center)
        }
        writeButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(messageTitleLabel.snp.bottom).offset(22)
            constraint.left.equalTo(32)
            constraint.width.equalTo(self.view.frame.width - 2 * 32)
            constraint.height.equalTo(50)
        }
        userName.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(profileImageView.snp.bottom).offset(20)
            constraint.centerX.equalTo(self.view.center)
        }
        profileImageBackgroundView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(backButton.snp.bottom).offset(5)
            constraint.height.width.equalTo(110)
            constraint.centerX.equalTo(self.view.center)
        }
        profileImageView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(backButton.snp.bottom).offset(10)
            constraint.height.width.equalTo(100)
            constraint.centerX.equalTo(self.view.center)
        }
        backButton.snp.makeConstraints { (constraint) in
            constraint.left.top.equalTo(32)
            constraint.width.height.equalTo(24)
        }
    }
}

extension MessageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultMessages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.messageCell, for: indexPath) as! MessageCollectionViewCell
        cell.textLabel.text = defaultMessages[indexPath.row]
        cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = defaultMessages[indexPath.row].count;
        return CGSize(width: width + 60, height: 22)
    }
}
