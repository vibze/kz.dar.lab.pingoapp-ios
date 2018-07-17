//
//  ComposeViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ComposeViewController: UITableViewController {
    
    let headerView = ComposeHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
    let footerView = ComposeFooterView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 160))
    var messageCell = "messageCell"
    var mainText: String?
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        viewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationController(backgrounColor: #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1), title: "")
    }
    
    func configTableView(){
        tableView.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    func viewData(){
        if let contact = contact {
            guard let avatarUrl = contact.avatarUrl else { return }
            headerView.viewData(image: avatarUrl, phoneNumber: contact.phoneNumber!, profileName: contact.name!)}
        footerView.composeButton.addTarget(self, action: #selector(composeButtonPressed), for: .touchUpInside)
        guard screenHeight == 568 else {
            return
        }
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
    
    @objc func composeButtonPressed() {
        view.endEditing(true)
        hideKeyboard()
        if footerView.messageText.text.isEmpty {
            self.showAlert(errorType: "Введите текст!", image: #imageLiteral(resourceName: "errorIcon"))
        } else {
            guard let buddy = contact
                ,let sendText = footerView.messageText.text
                ,let phoneNumber = buddy.phoneNumber,
                let date = buddy.pingedAt else { return }
            
            PingsApi().postPing(buddyId: buddy.profileId, pingText: sendText, success: { _ in
                let alertView = AlertViewController()
                alertView.configView(isError: false)
                alertView.delegate = self
                self.navigationController?.present(alertView, animated: false, completion: nil)
                Store.updateContactPingTime(phoneNumber: phoneNumber, date: date)
                self.footerView.messageText.text = ""
            }, failure: { _ in
                self.showAlert(errorType: "Ошибка! Сообщение не доставлено.", image: #imageLiteral(resourceName: "errorIcon"))
            })}
        print("tap&send")
    }
}

extension ComposeViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.hideKeyboard()
    }
}

extension ComposeViewController: AlertViewDelegate {
    func closeView(popupVC: AlertViewController) {
        dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
