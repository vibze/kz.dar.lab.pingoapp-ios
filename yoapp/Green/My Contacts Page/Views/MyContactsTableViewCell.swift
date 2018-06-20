//
//  MyContactsTableViewCell.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/20/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class MyContactsTableViewCell: UITableViewCell {

    let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50 / 2
        imageView.layer.borderColor = UIColor(hexString: "E36980").cgColor
        imageView.layer.borderWidth = 3
        imageView.image = #imageLiteral(resourceName: "contactPlaceholder")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let contactNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Chuck Norris"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "+77070070204"
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [contactImageView, phoneNumberLabel, contactNameLabel].forEach { (newView) in
            addSubview(newView)
        }
        
        contactImageView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(16)
            constraint.left.equalTo(20)
            constraint.width.height.equalTo(50)
        }
        contactNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(21)
            constraint.left.equalTo(contactImageView.snp.right).offset(20)
        }
        phoneNumberLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(contactNameLabel.snp.bottom)
            constraint.left.equalTo(contactImageView.snp.right).offset(20)
        }
    }

}
