//
//  MessageCollectionViewCell.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/20/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "asdasd"
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
            $0.height.equalTo(22)
        }
    }
    
}
