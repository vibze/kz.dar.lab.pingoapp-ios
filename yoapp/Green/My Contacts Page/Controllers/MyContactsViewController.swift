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
        tableView.rowHeight = 87
        tableView.tableFooterView = UIView()

        return tableView
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = UIFont(name: "Avenir Next", size: 16)
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
        ]
        
        textField.attributedPlaceholder = NSAttributedString(string: " Поиск", attributes: attributes)
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35).cgColor
        textField.backgroundColor = UIColor.init(hexString: "58AD7E")
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        var image = #imageLiteral(resourceName: "search")
        imageView.image = image
        textField.leftView = imageView
        textField.leftViewMode = UITextFieldViewMode.always
        textField.leftViewMode = .always
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexString: "6BBE90")
        viewsSetup()
    }
    
    func viewsSetup() {
        view.addSubview(tableView)
        view.addSubview(searchTextField)
        
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyContactsTableViewCell.self, forCellReuseIdentifier: Constants.myContactCell)

        searchTextField.snp.makeConstraints { (constraint) in
            constraint.top.left.equalTo(20)
            constraint.height.equalTo(48)
            constraint.width.equalTo(self.view.frame.width - 2 * 20)
        }
        tableView.snp.makeConstraints { (constraint) in
            constraint.bottom.left.right.equalTo(0)
            constraint.top.equalTo(searchTextField.snp.bottom).offset(12)
        }
    }
}

extension MyContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.myContactCell, for: indexPath) as! MyContactsTableViewCell
        cell.backgroundColor = .clear
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(hexString: "81E2AA")
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor.init(hexString: "308757")
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Все контакты"

        headerView.addSubview(headerLabel)
        return headerView
    }
}

extension MyContactsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.never
        textField.leftViewMode = .never
        self.hideKeyboard()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 0 {
                textField.leftViewMode = UITextFieldViewMode.always
                textField.leftViewMode = .always
            }
        }
    }
}

