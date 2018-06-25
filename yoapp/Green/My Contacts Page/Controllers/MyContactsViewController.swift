//
//  MyContactsViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import Contacts

private struct Constants {
    static let myContactCell = "myContactCell"
}

class MyContactsViewController: UIViewController {
    
    var myContacts: [ContactsService] = []

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        tableView.separatorColor = UIColor(hexString: "58AD7E")
        tableView.rowHeight = 82
        tableView.tableFooterView = UIView()
        
        return tableView
    }()
    
    let searchTextField = SearchTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "6BBE90")
        setupViews()
        fetchContacts()
    }
    
    func fetchContacts() {
        ContactsService.syncContacts { (contactsData, message) in
            if let message = message {
                print(message)
                return
            }
            self.myContacts = contactsData!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(searchTextField)
        
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyContactsTableViewCell.self, forCellReuseIdentifier: Constants.myContactCell)

        searchTextField.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(20)
            $0.height.equalTo(48)
            $0.width.equalToSuperview().inset(20)
        }
        tableView.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview().offset(0)
            $0.top.equalTo(searchTextField.snp.bottom).offset(12)
        }
    }
}

extension MyContactsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myContactCell, for: indexPath) as! MyContactsTableViewCell
        if let contact = myContacts[indexPath.row].contact {
            cell.setupValues(contact: contact)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionHeaderView()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.dismissKeyboard()
    }
}

extension MyContactsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hideKeyboard()
    }
}

