//
//  MessageTableViewCell.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/19/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    var sampleMessageText: String?
    
    let sampleMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 18)
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
        if let sampleMessage = sampleMessageText {
            sampleMessageLabel.text = sampleMessage
        }
        
        addSubview(sampleMessageLabel)
        sampleMessageLabel.snp.makeConstraints { (constraint) in
            constraint.top.bottom.right.equalTo(0)
            constraint.left.equalTo(16)
        }
    }
}
