//
//  MyContactsTableViewCell.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/20/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import Contacts

class MyContactsTableViewCell: UITableViewCell {
    
    var contact: Contact? {
        didSet {
            guard let contact = contact else { return }
            contactDidUpdate(contact)
        }
    }

    let contactImageView = ImageView(radius: 55 / 2)
    
    let contactNameLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 16, fontType: .myRegular)
    let phoneNumberLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 14, fontType: .myRegular)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    func contactDidUpdate(_ contact: Contact) {
        contactNameLabel.text = contact.name ?? ""
        phoneNumberLabel.text = "+" + contact.phoneNumber!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [contactImageView, phoneNumberLabel, contactNameLabel].forEach {
            addSubview($0)
        }
        
        contactImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(55)
        }
        contactNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.left.equalTo(contactImageView.snp.right).offset(20)
        }
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(contactNameLabel.snp.bottom)
            $0.left.equalTo(contactImageView.snp.right).offset(20)
        }
    }

}
