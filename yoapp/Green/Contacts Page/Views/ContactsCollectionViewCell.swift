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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .red
        return indicatorView
    }()
    
    let contactNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
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
        addSubview(contactImageView)
        addSubview(contactNameLabel)
        contactImageView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(contactImageView.snp.center)
        }
        
        contactImageView.snp.makeConstraints { (constraint) in
            constraint.top.left.right.equalTo(0)
            constraint.width.height.equalTo(68)
        }
        contactNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(contactImageView.snp.bottom).offset(10)
            constraint.left.right.equalTo(0)
        }
    }
}
