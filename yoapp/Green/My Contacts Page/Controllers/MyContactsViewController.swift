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

private struct Constants {
    static let myContactCell = "myContactCell"
}

class MyContactsViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = true
        tableView.separatorColor = UIColor(hexString: "58AD7E")
        tableView.rowHeight = 82
        
        return tableView
    }()
    
    var listOfContacts: [Contact] = []
    
    let searchBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "6BBE90")
        return view
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effect.isHidden = true
        return effect
    }()

    
    let searchTextField = SearchTextField()
    let monitor = Monitor.contactsMonitor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        monitor.addObserver(self)
        listOfContacts = monitor.objectsInAllSections()
        
        view.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1)
        
        setupViews()
    }
    
    @objc func handleTextFieldChange(textField: UITextField) {
        self.listOfContacts = SearchContact.searchFor(monitor: monitor, text: textField.text)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupViews() {
        view.addSubview(tableView)
        view.addSubview(searchBackgroundView)
        searchBackgroundView.addSubview(blurEffectView)
        searchBackgroundView.addSubview(searchTextField)
        
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyContactsTableViewCell.self, forCellReuseIdentifier: Constants.myContactCell)
        
        tableView.keyboardDismissMode = .onDrag
        tableView.contentInset = UIEdgeInsets(top: 75, left: 0, bottom: 60, right: 0)
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            blurEffectView.isHidden = false
            searchBackgroundView.backgroundColor = .clear
            searchTextField.backgroundColor = UIColor(hexString: "58AD7E", alpha: 0.2)
        }
        else {
            blurEffectView.isHidden = true
            searchBackgroundView.backgroundColor = UIColor(hexString: "6BBE90")
            searchTextField.backgroundColor = UIColor(hexString: "58AD7E")
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
        self.tableView.reloadData()
    }
    func listMonitorDidRefetch(_ monitor: ListMonitor<Contact>) {
    }
}


