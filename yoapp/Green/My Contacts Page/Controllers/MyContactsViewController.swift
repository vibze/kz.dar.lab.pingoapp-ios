//
//  MyContactsViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/18/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

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
        tableView.tableFooterView = UIView()

        return tableView
    }()
    
    let searchTextField = SearchTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "6BBE90")
        setupViews()
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

extension MyContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myContactCell, for: indexPath) as! MyContactsTableViewCell
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(hexString: "81E2AA")
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor.init(hexString: "308757")
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Все контакты"
        headerView.addSubview(headerLabel)
        containerView.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(5)
            $0.left.equalTo(containerView.snp.left).offset(0)
            $0.width.equalTo(containerView.snp.width)
            $0.height.equalTo(25)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(5)
            $0.left.equalTo(containerView.snp.left).offset(20)
            $0.width.equalTo(containerView.snp.width)
            $0.height.equalTo(25)
        }
        return containerView
    }
}

extension MyContactsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.never
        textField.leftViewMode = .never
        self.hideKeyboard()
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 0 {
                textField.leftViewMode = UITextFieldViewMode.always
                textField.leftViewMode = .always
                let attributes = [
                    NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                ]
                textField.attributedPlaceholder = NSAttributedString(string: "Поиск", attributes: attributes)
            }
        }
    }
}

