//
//  ContactsCollectionViewCell.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/17/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import SnapKit

class ContactsCollectionViewCell: UICollectionViewCell {
    
    let contactImageView = ImageView(radius: 68 / 2)

    let contactNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "removeIcon"), for: .normal)
        button.isHidden = true
        return button
    }()

    let longPressTapGestureRecognizer: UILongPressGestureRecognizer = {
        let tapRecognizer = UILongPressGestureRecognizer()
        tapRecognizer.minimumPressDuration = 1
        
        return tapRecognizer
    }()

    var contact: Contact? {
        didSet {
            guard let contact = contact else { return }
            contactDidUpdate(contact)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        removeButton.addTarget(self, action: #selector(removeButtonPressed), for: .touchUpInside)
        longPressTapGestureRecognizer.addTarget(self, action: #selector(handleLongPressTap))
    }
    
    @objc func removeButtonPressed() {
        print("hello")
    }

    @objc func handleLongPressTap(sender: UILongPressGestureRecognizer) {
        removeButton.isHidden = false
    }
    
    func contactDidUpdate(_ contact: Contact) {
        contactImageView.image = #imageLiteral(resourceName: "contactPlaceholder")
        guard let contactName = contact.name else { return }
        contactNameLabel.text = contactName
        if let avatarUrl = contact.avatarUrl {
            contactImageView.setContactImage(url: avatarUrl)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func addViews() {
        [contactImageView, contactNameLabel, removeButton].forEach {
            addSubview($0)
        }
        addGestureRecognizer(longPressTapGestureRecognizer)

        removeButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(-10)
            $0.right.equalTo(self.snp.right).offset(10)
            $0.width.height.equalTo(30)
        }

        contactImageView.snp.makeConstraints { (constraint) in
            constraint.top.left.right.equalTo(0)
            constraint.width.height.equalTo(68)
        }
        contactNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(contactImageView.snp.bottom).offset(5)
            constraint.left.right.equalTo(0)
        }
    }
}
