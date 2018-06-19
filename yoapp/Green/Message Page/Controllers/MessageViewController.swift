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

    let defaultMessages = ["Привет", "Как дела?"]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = true
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 8
        tableView.rowHeight = 40
        return tableView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 120 / 2
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.init(hexString: "9C4272").cgColor
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
        username.text = "Someone"
        username.textAlignment = .center
        username.font = UIFont(name: "Avenir Next", size: 24)
        username.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return username
    }()
    
    let writeButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(writeBtnPressed), for: .touchUpInside)
        btn.setTitle("Написать текст", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btn.layer.borderWidth = 0.5
        btn.setTitleColor(UIColor.init(hexString: "9C4272"), for: .normal)
        btn.backgroundColor = UIColor.init(hexString: "81E2AA")
        return btn
    }()
    
    let sendBtn: UIButton = {
        let sendBtn = UIButton()
        sendBtn.addTarget(self, action: #selector(sendBtnPressed), for: .touchUpInside)
        sendBtn.layer.masksToBounds = true
        sendBtn.layer.cornerRadius = 10
        sendBtn.backgroundColor = .red
        
        return sendBtn
    }()
    
    let cancelBtn: UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
        cancelBtn.layer.masksToBounds = true
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.backgroundColor = .blue
        
        return cancelBtn
    }()
    
    let sendMessageAlertView: UIView = {
        let sendView = UIView()
        sendView.layer.masksToBounds = true
        sendView.layer.cornerRadius = 10
        sendView.backgroundColor = .green
        
        return sendView
    }()
    
    let newMessageTextField: UITextField = {
        let message = UITextField()
        return message
    }()

    @objc func sendBtnPressed() {
        
    }
    
    @objc func cancelBtnPressed() {
        sendMessageAlertView.isHidden = true
        [cancelBtn, sendBtn].forEach { (button) in
            button.isEnabled = false
            button.isHidden = true
        }
    }
    
    @objc func writeBtnPressed() {
        sendMessageAlertView.isHidden = false
        [cancelBtn, sendBtn].forEach { (button) in
            button.isEnabled = true
            button.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        backImageSet()
        setupCustomAlert()
    }
    
    @objc func backBtnPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func backImageSet() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "contactsBackground")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func setupCustomAlert() {
        [sendMessageAlertView, newMessageTextField, sendBtn, cancelBtn].forEach { (newView) in
            view.addSubview(newView)
        }
        sendBtn.snp.makeConstraints { (constraint) in
            constraint.bottom.equalTo(sendMessageAlertView.snp.bottom)
            constraint.left.equalTo(sendMessageAlertView.snp.left)
            constraint.width.equalTo(300 / 2)
            constraint.height.equalTo(35)
        }
        cancelBtn.snp.makeConstraints { (constraint) in
            constraint.bottom.equalTo(sendMessageAlertView.snp.bottom)
            constraint.right.equalTo(sendMessageAlertView.snp.right)
            constraint.width.equalTo(300 / 2)
            constraint.height.equalTo(35)
        }
        sendMessageAlertView.snp.makeConstraints { (constraint) in
            constraint.centerX.equalTo(self.view.center)
            constraint.centerY.equalTo(self.view.center)
            constraint.width.equalTo(300)
            constraint.height.equalTo(178)
        }
//        messageContentTextField.snp.makeConstraints { (constraint) in
//            constraint.top.equalTo(sendMessageAlertView.snp.top)
//            constraint.left.equalTo(sendMessageAlertView.snp.left)
//            constraint.right.equalTo(sendMessageAlertView.snp.right)
//            constraint.bottom.equalTo(sendMessageAlertView.snp.bottom)
//        }
    }
    
    func setupViews() {
        [backButton, profileImageView, tableView, userName, writeButton].forEach { newView in
            view.addSubview(newView)
        }
        
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: Constants.messageCell)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(userName.snp.bottom).offset(50)
            constraint.left.equalTo(30)
            constraint.height.equalTo(239)
            constraint.width.equalTo(self.view.frame.width - 2 * 30)
        }
        writeButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(tableView.snp.bottom).offset(40)
            constraint.left.equalTo(62)
            constraint.width.equalTo(self.view.frame.width - 2 * 62)
            constraint.height.equalTo(43)
        }
        userName.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(profileImageView.snp.bottom).offset(20)
            constraint.centerX.equalTo(self.view.center)
        }
        profileImageView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(29)
            constraint.height.width.equalTo(120)
            constraint.centerX.equalTo(self.view.center)
        }
        backButton.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(16)
            constraint.top.equalTo(20)
            constraint.width.height.equalTo(35)
        }
    }
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.messageCell, for: indexPath) as! MessageTableViewCell
        cell.sampleMessageText = defaultMessages[indexPath.row]
//        cell.sampleMessageLabel.text = defaultMessages[indexPath.row]
        return cell
    }
}
