//
//  MyContactsViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import Contacts
import CoreStore
import MessageUI

private struct Constants {
    static let myContactCell = "myContactCell"
}

class MyContactsViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    let emptyListView: BlackListFooterView = {
        let emptyView = BlackListFooterView()
        emptyView.backgroundColor = #colorLiteral(red: 0.431372549, green: 0.6588235294, blue: 0.8431372549, alpha: 1)
        emptyView.isHidden = true
        return emptyView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        tableView.separatorColor = #colorLiteral(red: 0.431372549, green: 0.6588235294, blue: 0.8431372549, alpha: 1)
        tableView.rowHeight = 82
        
        return tableView
    }()
    
    let refreshController: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .white
        refresh.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        return refresh
    }()
    
    let searchBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.431372549, green: 0.6588235294, blue: 0.8431372549, alpha: 1)
        return view
    }()
    
    let blurEffectView = UIVisualEffectView.getBlurEffectView()
    let searchTextField = SearchTextField()
    
    var listOfContacts: [Contact] = []
    let monitor = Monitor.contactsMonitor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.431372549, green: 0.6588235294, blue: 0.8431372549, alpha: 1)
        
        monitor.addObserver(self)
        listOfContacts = monitor.objectsInAllSections()
        
        setupViews()
        setupTargets()
        checkForContactsExistence()
    }
    
    func checkForContactsExistence() {
        emptyListView.isHidden = listOfContacts.count > 0 ? true : false
    }
    
    @objc func cancelButtonPressed(sender: UIButton) {
        sender.isHidden = true
        searchTextField.text = ""
        handleTextFieldChange(textField: searchTextField)
    }
    
    @objc func handleTextFieldChange(textField: UITextField) {
        textField.rightView?.isHidden = textField.text?.count == 0 ? true : false

        self.listOfContacts = SearchContact.searchFor(monitor: monitor, text: textField.text)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func handlePullToRefresh(_ sender: UIRefreshControl) {
        tableView.reloadData()
        checkForContactsExistence()
        sender.endRefreshing()
    }
    
    func setupTargets() {
        searchTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        (searchTextField.rightView as! UIButton).addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
    
    func setupViews() {
        [tableView, searchBackgroundView, emptyListView].forEach {
            view.addSubview($0)
        }
        [blurEffectView, searchTextField].forEach {
            searchBackgroundView.addSubview($0)
        }
        tableView.addSubview(refreshController)
        
        searchTextField.delegate = self
        searchTextField.backgroundColor = UIColor.init(hexString: "5D93BF")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyContactsTableViewCell.self, forCellReuseIdentifier: Constants.myContactCell)
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = UIEdgeInsets(top: 75, left: 0, bottom: 60, right: 0)
        
        
        emptyListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        blurEffectView.snp.makeConstraints {
            $0.edges.equalTo(searchBackgroundView.snp.edges)
        }
        searchBackgroundView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(80)
        }
        searchTextField.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(20)
            $0.height.equalTo(48)
            $0.width.equalToSuperview().inset(20)
        }
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        emptyListView.viewData(text: "Добавьте контакты в свой телефон", image: #imageLiteral(resourceName: "inviteFriends"))
    }
}

extension MyContactsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myContactCell, for: indexPath) as! MyContactsTableViewCell
        cell.contact = listOfContacts[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneNumber = listOfContacts[indexPath.row].phoneNumber
      
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Привет! Установливай Pingo приложение и отправляй ping своим друзьям."
            controller.recipients = ([phoneNumber] as! [String])
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {

        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y > 0 ?
            setBlur(false, .clear, #colorLiteral(red: 0.3450980392, green: 0.6784313725, blue: 0.4941176471, alpha: 0.2)) :
            setBlur(true, #colorLiteral(red: 0.431372549, green: 0.6588235294, blue: 0.8431372549, alpha: 1), #colorLiteral(red: 0.431372549, green: 0.6588235294, blue: 0.8431372549, alpha: 1))
    }
    
    func setBlur(_ isHidden: Bool, _ backColor: UIColor, _ textColor: UIColor) {
        UIView.animate(withDuration: (isHidden ? 0 : 0.5)) {
            self.blurEffectView.isHidden = isHidden
            self.searchBackgroundView.backgroundColor = backColor
            self.searchTextField.backgroundColor = textColor
        }
    }
}

extension MyContactsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hideKeyboard()
    }
}

extension MyContactsViewController: ListObserver {
    func listMonitorDidChange(_ monitor: ListMonitor<Contact>) {
        listOfContacts = monitor.objectsInAllSections()
        checkForContactsExistence()
        self.tableView.reloadData()
    }
    func listMonitorDidRefetch(_ monitor: ListMonitor<Contact>) {
    }
}


