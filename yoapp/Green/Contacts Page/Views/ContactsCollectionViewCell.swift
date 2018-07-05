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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    var contact: Contact? {
        didSet {
            guard let contact = contact else { return }
            contactDidUpdate(contact)
        }
    }
    
    func contactSetImage(_ imageUrl: String) {
        activityIndicator.startAnimating()
        DispatchQueue.main.async {
            Image().getProfileImage(url: imageUrl) { (data, message) in
                if let message = message {
                    print(message)
                }
                else {
                    if let data = data {
                        self.contactImageView.image = UIImage(data: data)
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    func contactDidUpdate(_ contact: Contact) {
        guard let contactName = contact.name, let avatarUrl = contact.avatarUrl else { return }
        contactNameLabel.text = contactName
        contactSetImage(avatarUrl)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

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
